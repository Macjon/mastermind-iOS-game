import XCTest
@testable import MastermindGame

final class GameServiceTests: XCTestCase {
    private var sut: GameServiceProtocol!

    override func setUp() {
        super.setUp()
        sut = GameService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGenerateSecretReturns4Characters() {
        let secret = sut.generateSecret()
        XCTAssertEqual(secret.count, sut.secretCount)
    }

    func testGeneratedSecretCharactersAreWithinAtoZ() {
        let secret = sut.generateSecret()
        let validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        XCTAssertTrue(secret.allSatisfy { validChars.contains($0) })
    }

    func testCheckGuessReturnsEmptyForInvalidInput() {
        let results = sut.checkGuess(guess: ["A", "B"], secret: "ABCD")
        XCTAssertTrue(results.isEmpty)
    }

    func testCheckGuessAllCorrect() {
        let results = sut.checkGuess(guess: ["K", "B", "C", "D"], secret: "KBCD")
        XCTAssertEqual(results, [.correct, .correct, .correct, .correct])
    }

    func testCheckGuessMixedCorrectAndWrongAndMisplaced() {
        let results = sut.checkGuess(guess: ["K", "X", "B", "C"], secret: "KBCD")
        XCTAssertEqual(results[0], .correct)
        XCTAssertEqual(results[1], .wrong)
        XCTAssertEqual(results[2], .misplaced)
        XCTAssertEqual(results[3], .misplaced)
    }
}
