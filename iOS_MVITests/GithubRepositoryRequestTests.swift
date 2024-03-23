import XCTest
@testable import iOS_MVI

class GithubRepositoryRequestTests: XCTestCase {

    func testGetProfileRequest() {
        // Given
        let request = GithubRepositoryRequest(apiRepo: .getProfile)

        // When
        let path = request.path
        let params = request.params
        let method = request.method
        let body = request.body

        // Then
        XCTAssertEqual(path, "serdarbakirtas")
        XCTAssertNil(params)
        XCTAssertEqual(method, .get)
        XCTAssertNil(body)
    }

    func testDecoding() throws {
        // Given
        let json = """
        {
            "login": "testUser",
            "followers": 500,
            "following": 200
        }
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()

        // When
        let user = try decoder.decode(GithubRepositoryRequest.Response.self, from: data)

        // Then
        XCTAssertEqual(user.login, "testUser")
        XCTAssertEqual(user.followers, 500)
        XCTAssertEqual(user.following, 200)
    }
}
