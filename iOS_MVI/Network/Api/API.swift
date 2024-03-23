import Foundation

protocol APIRepo {
    func response<Request: CodableAPIRequest>(from request: Request) async throws -> Request.Response
}

struct API: APIRepo {

    private let apiUrlRequest: APIURLRequest
    
    init() {
        self.apiUrlRequest = APIURLRequest()
    }
    
    func response<Request: CodableAPIRequest>(from request: Request) async throws -> Request.Response {

        let urlRequest: URLRequest
        do {
            urlRequest = try apiUrlRequest.executeUrlRequest(for: request)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse else {
                Logger.error(response)
                throw APIError.responseError
            }
            
            guard HTTPCodes.success ~= response.statusCode else {
                Logger.error(response.statusCode)
                throw APIError.httpCode(response.statusCode)
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(Request.Response.self, from: data)
            } catch {
                throw APIError.parseError(error)
            }
            
        } catch {
            throw APIError.unexpectedResponse(error)
        }
    }
}
