import XCTest
@testable import CleanArchitecture

// Create a mock API repository that throws an error
class FailingMockAPIRepository: APIRepo {
    
    func response<Request>(from request: Request) async throws -> Request.Response where Request : CodableAPIRequest {
        throw APIError.responseError
    }
}
