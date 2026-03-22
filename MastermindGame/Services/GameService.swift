import Foundation

protocol GameServiceProtocol {
    var secretCount: Int { get }
    func generateSecret() -> String
    func checkGuess(guess: [String], secret: String) -> [GuessResult]
}

final class GameService: GameServiceProtocol {
    internal let secretCount: Int = 4

    func generateSecret() -> String {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return String((0..<secretCount).map { _ in letters.randomElement()! })
    }

    func checkGuess(guess: [String], secret: String) -> [GuessResult] {

        guard guess.count == secretCount, secret.count == secretCount else {
            return []
        }

        var results: [GuessResult] = [GuessResult.wrong, GuessResult.wrong, GuessResult.wrong, GuessResult.wrong]
        let secretChars = Array(secret)

        // Use a Set because it's faster
        var usedSecretIndices = Set<Int>()
        var usedGuessIndices = Set<Int>()

        // Search for exact matches
        for i in 0..<secretCount {
            if guess[i] == String(secretChars[i]) {
                results[i] = .correct
                usedSecretIndices.insert(i)
                usedGuessIndices.insert(i)
            }
        }

        for i in 0..<secretCount {

            // Skip position which is already marked as exact match
            guard !usedGuessIndices.contains(i) else {
                continue
            }

            // Check all positions of not checked matches
            for j in 0..<secretCount {

                guard !usedSecretIndices.contains(j) else {
                    continue
                }

                if guess[i] == String(secretChars[j]) {
                    results[i] = .misplaced
                    usedSecretIndices.insert(j)
                    break
                }
            }
        }

        return results
    }
}
