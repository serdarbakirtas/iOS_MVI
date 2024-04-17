import XCTest
@testable import iOS_MVI

final class MockAPIRepository: APIRepo {

    func response<Request>(from request: Request) async throws -> Request.Response where Request : CodableAPIRequest {
        // Return the mock data for the GitHubUser response
        let mockUser = GitHubUser(login: "testUser", followers: 500, following: 200)
        return mockUser as! Request.Response
    }
}
