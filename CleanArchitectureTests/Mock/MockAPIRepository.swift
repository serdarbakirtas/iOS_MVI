import XCTest
@testable import CleanArchitecture

final class MockAPIRepository: APIRepo {

    func response<Request>(from request: Request) async throws -> Request.Response where Request : CodableAPIRequest {
        // Return the mock data for the GetAUser response
        let mockUser = GetAUser(login: "testUser", followers: 500, following: 200)
        return mockUser as! Request.Response
    }
}


