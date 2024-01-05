import Foundation

// Parameters and values
protocol APIRequestType {

    var path: String { get }
    var method: HTTPMethod { get }
    var params: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
}

// Generic types
protocol DecodableAPIRequest: APIRequestType {
    associatedtype Response: Decodable
}
typealias CodableAPIRequest = DecodableAPIRequest
