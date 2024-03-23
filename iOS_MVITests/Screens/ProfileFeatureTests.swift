@testable import iOS_MVI
import XCTest

final class ProfileFeatureTests: XCTestCase {
    var sut: ProfileFeature!

    override func setUp() {
        super.setUp()

        sut = ProfileFeature()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testViewAppearedIntent() async throws {
        // Given
        InjectedValues[\.networkProvider] = MockAPIRepository()

        // When
        await sut.reduce(intent: .viewAppeared)
        guard let dataSource = sut.viewState.dataSource else { return }
        let result: GetAUser = dataSource

        // Then
        XCTAssertEqual(result.login, "testUser")
        XCTAssertEqual(result.followers, 500)
        XCTAssertEqual(result.following, 200)
    }
}
