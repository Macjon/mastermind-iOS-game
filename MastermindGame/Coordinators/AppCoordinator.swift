import Foundation
import Combine
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {

    enum Route: Hashable {
        case game
        case succes
        case gameOver(secret: String)
    }

    @Published var navigationPath = NavigationPath()
    @Published private(set) var gameViewModel: GameViewModel

    private var cancellables = Set<AnyCancellable>()

    init(gameService: GameServiceProtocol = GameService(), timerService: TimerServiceProtocol = TimerService()) {
        self.gameViewModel = GameViewModel(gameService: gameService, timerService: timerService)
        observeGameState()
    }

    func startGame() {
        navigationPath.append(Route.game)
    }

    func restartGame() {
        cancellables.removeAll()
        navigationPath = NavigationPath()
        gameViewModel = GameViewModel(gameService: GameService(), timerService: TimerService())
        observeGameState()
    }

    private func observeGameState() {
        gameViewModel.$gameState
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .won:
                    navigationPath.append(Route.succes)
                case .gameOver:
                    navigationPath.append(Route.gameOver(secret: gameViewModel.secret))
                case .playing:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
