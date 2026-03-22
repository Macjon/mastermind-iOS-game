import Foundation

protocol GameServiceProtocol {
    func generateSecret() -> String
}

final class GameService: GameServiceProtocol {
    func generateSecret() -> String {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return String((0..<4).map { _ in letters.randomElement()! })
    }
}
