import XCTest
@testable import iOS_MVI

class StandardGithubRepositoryTests: XCTestCase {

    var sut: StandardGithubRepository!
    
    override func setUp() {

        super.setUp()

        sut = StandardGithubRepository()
    }

    func testFetchProfileSuccess() async {
        InjectedValues[\.networkProvider] = MockAPIRepository()
        
        do {
            // Assuming the mock repository returns the profile data
            let result = try await sut.networkProvider.response(from: GithubRepositoryRequest(apiRepo: .getProfile))

            // Check if the result is not nil
            XCTAssertNotNil(result)

            // Check if the returned profile matches the expected values
            XCTAssertEqual(result.login, "testUser")
            XCTAssertEqual(result.followers, 500)
            XCTAssertEqual(result.following, 200)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchProfileFailure() async {
        
        // Initialize the repository with the failing mock API repository
        InjectedValues[\.networkProvider] = FailingMockAPIRepository()
        
        do {
            // Assuming the mock repository returns the profile data
            let result = try await sut.networkProvider.response(from: GithubRepositoryRequest(apiRepo: .getProfile))

            // Check if the result is nil
            XCTAssertNil(result)
        } catch {
            // Check if the error is of the expected type
            XCTAssertTrue(error is APIError)
            XCTAssertEqual((error as? APIError), APIError.responseError)
        }
    }
}
