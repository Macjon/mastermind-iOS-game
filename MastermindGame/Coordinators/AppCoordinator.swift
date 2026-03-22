import Foundation
import Combine
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject, AppRouter {

    enum Route: Hashable {
        case game
    }

    @Published var navigationPath = NavigationPath()

    func navigate(to route: Route) {
        navigationPath.append(route)
    }
}
