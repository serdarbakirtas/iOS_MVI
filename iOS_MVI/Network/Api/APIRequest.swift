import Foundation

final class APIURLRequest {
    /// Production Base URL
    private let baseURL = URL(string: "https://api.github.com/users/")!

    func executeUrlRequest(for request: APIRequestType) throws -> URLRequest {
        // merge base url with path url
        let url = baseURL.appendingPathComponent(request.path)

        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw APIError.authenticationError
        }

        // paramters are needed
        if let params = request.params {
            urlComponents.queryItems = params
        }

        guard let pathURL = urlComponents.url else {
            throw APIError.authenticationError
        }

        // create URL request
        var urlRequest = URLRequest(url: pathURL)
        urlRequest.httpMethod = request.method.rawValue
        if let body = request.body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch {
                throw APIError.requestError
            }
        }

        // header fields
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return urlRequest
    }
}
