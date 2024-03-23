import XCTest
@testable import iOS_MVI

// Create a mock API repository that throws an error
class FailingMockAPIRepository: APIRepo {
    
    func response<Request>(from request: Request) async throws -> Request.Response where Request : CodableAPIRequest {
        throw APIError.responseError
    }
}
