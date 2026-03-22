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
        XCTAssertEqual(secret.count, 4)
    }

    func testGeneratedSecretCharactersAreWithinAtoZ() {
        let secret = sut.generateSecret()
        let validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        XCTAssertTrue(secret.allSatisfy { validChars.contains($0) })
    }
}
