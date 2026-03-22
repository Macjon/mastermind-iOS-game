import SwiftUI

struct RootView: View {
    @StateObject private var coordinator = AppCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            StartView(onStart: { coordinator.startGame() })
                .navigationDestination(for: AppCoordinator.Route.self) { route in
                switch route {
                case .game:
                    GameView()
                }
            }
        }
    }
}
