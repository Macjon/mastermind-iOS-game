import Foundation
import Combine

@MainActor
final class GameViewModel: ObservableObject {
    @Published private(set) var completedGuesses: [[LetterBox]] = []
    @Published private(set) var gameState: GameState = .playing
    @Published private(set) var remainingTime: Int

    let secret: String
    var maxGameDurationInSeconds: Int {
        get {
            return timerService.maxGameDurationInSeconds
        }
    }

    private let gameService: GameServiceProtocol
    private let timerService: TimerServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(gameService: GameServiceProtocol, timerService: TimerServiceProtocol) {
        self.gameService = gameService
        self.timerService = timerService
        self.remainingTime = timerService.maxGameDurationInSeconds

        let generated = gameService.generateSecret()
        self.secret = generated

        print("🔑 Secret: \(generated)")

        setupSubscriptions()
    }

    func startGame() {
        timerService.start()
    }

    func checkGuess(letters: [String]) {
        guard gameState == .playing else {
            return
        }

        guard letters.allSatisfy({ !$0.isEmpty }) else {
            return
        }

        let results = gameService.checkGuess(guess: letters, secret: secret)
        let row = (0..<gameService.secretCount).map { i in
            LetterBox(id: i, letter: letters[i], result: results[i])
        }
        completedGuesses.append(row)

        if results.allSatisfy({ $0 == .correct }) {
            gameState = .won
        }
    }

    private func setupSubscriptions() {
        timerService.remainingTimePublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.remainingTime, on: self)
            .store(in: &cancellables)

        timerService.timerFinishedPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.gameState = .gameOver
            }
            .store(in: &cancellables)
    }
}
