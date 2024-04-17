import Foundation

protocol APIRepo {
    func response<Request: CodableAPIRequest>(from request: Request) async throws -> Request.Response
}

struct API: APIRepo {
    private let apiUrlRequest: APIURLRequest

    init() {
        apiUrlRequest = APIURLRequest()
    }

    func response<Request: CodableAPIRequest>(from request: Request) async throws -> Request.Response {
        try await simulateServerResponse()
        return try await decodeData(from: request)
    }
}

// MARK: - Private functions

extension API {
    // Simulate server response delay
    private func simulateServerResponse() async throws {
        let delayDuration = TimeInterval.random(in: 1 ... 2)
        try await Task.sleep(nanoseconds: UInt64(delayDuration * 1_000_000_000))
    }

    // Decode data received from server
    private func decodeData<Request: CodableAPIRequest>(from request: Request) async throws -> Request.Response {
        let urlRequest = try apiUrlRequest.executeUrlRequest(for: request)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        return try handleResponse(response, data: data)
    }

    // Handle HTTP response and decode data
    private func handleResponse<Response: Decodable>(_ response: URLResponse, data: Data) throws -> Response {
        try validateResponse(response)
        return try decodeData(data: data)
    }

    // Validate HTTP response
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.responseError
        }

        guard HTTPCodes.success ~= httpResponse.statusCode else {
            throw APIError.httpCode(httpResponse.statusCode)
        }
    }

    // Decode JSON data
    private func decodeData<Response: Decodable>(data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: data)
    }
}
