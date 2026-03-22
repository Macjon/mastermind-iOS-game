import SwiftUI

@MainActor
protocol AppRouter: AnyObject {
    associatedtype Route: Hashable
    var navigationPath: NavigationPath { get set }
    func navigate(to route: Route)
}
