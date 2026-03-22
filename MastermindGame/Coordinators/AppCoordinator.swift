import Foundation
import Combine
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {

    enum Route: Hashable {
        case game
    }

    @Published var navigationPath = NavigationPath()

    func startGame() {
        navigationPath.append(Route.game)
    }
}
