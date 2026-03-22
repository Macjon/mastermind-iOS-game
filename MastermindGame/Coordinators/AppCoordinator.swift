import Foundation
import Combine
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {

    enum Route: Hashable {
        case game
    }

    @Published var navigationPath = NavigationPath()
    @Published private(set) var gameViewModel: GameViewModel

    private let gameServiceFactory: () -> GameServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(gameServiceFactory: @escaping () -> GameServiceProtocol = { GameService() } ) {
        self.gameServiceFactory = gameServiceFactory
        self.gameViewModel = GameViewModel(gameService: gameServiceFactory())
        observeGameState()
    }

    func startGame() {
        navigationPath.append(Route.game)
    }

    private func observeGameState() {
        gameViewModel.$gameState
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .won:
                    print("==== Yes we won")
                case .lost:
                    print("==== Damn we lost")
                case .playing:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
