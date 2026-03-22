import Combine

@MainActor
final class GameViewModel: ObservableObject {
    @Published private(set) var completedGuesses: [[LetterBox]] = []
    @Published private(set) var gameState: GameState = .playing

    let secret: String

    private let gameService: GameServiceProtocol

    init(gameService: GameServiceProtocol) {
        self.gameService = gameService

        let generated = gameService.generateSecret()
        self.secret = generated

        print("🔑 Secret: \(generated)")
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
}
