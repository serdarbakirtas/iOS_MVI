import Foundation

enum APIError: Error, Equatable {
    case invalidURL
    case httpCode(HTTPCode)
    case authenticationError
    case unexpectedError(message: String)
    case unexpectedResponse(_ : Error)
    case responseError
    case parseError(_ : Error)

    // Equatable conformance
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.authenticationError, .authenticationError),
             (.responseError, .responseError):
            return true
        case let (.httpCode(code1), .httpCode(code2)):
            return code1 == code2
        case let (.unexpectedError(message1), .unexpectedError(message2)):
            return message1 == message2
        case let (.unexpectedResponse(error1), .unexpectedResponse(error2)):
            return error1.localizedDescription == error2.localizedDescription
        case let (.parseError(error1), .parseError(error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
}

// MARK: Message types
extension APIError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .authenticationError:
            return "authenticationError"
        case .unexpectedError(message: let message):
            return message
        case .unexpectedResponse(let errorMessage):
            return errorMessage.localizedDescription
        case .responseError:
            return "responseError"
        case .parseError(let errorMessage):
            return "parseError is \(errorMessage)"
        case .invalidURL:
            return "Invalid URL"
        case let .httpCode(code):
            return "Unexpected HTTP code: \(code)"
        }
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
