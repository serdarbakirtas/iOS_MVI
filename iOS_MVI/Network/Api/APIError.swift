import Foundation

enum APIError: Error, Equatable {
    case invalidURL
    case httpCode(HTTPCode)
    case authenticationError
    case unexpectedError(message: String)
    case unexpectedResponse(_: Error)
    case responseError
    case requestError
    case parseError(_: Error)

    // Equatable conformance
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.authenticationError, .authenticationError),
             (.responseError, .responseError):
            true
        case let (.httpCode(code1), .httpCode(code2)):
            code1 == code2
        case let (.unexpectedError(message1), .unexpectedError(message2)):
            message1 == message2
        case let (.unexpectedResponse(error1), .unexpectedResponse(error2)):
            error1.localizedDescription == error2.localizedDescription
        case let (.parseError(error1), .parseError(error2)):
            error1.localizedDescription == error2.localizedDescription
        default:
            false
        }
    }
}

// MARK: Message types

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .authenticationError:
            "authenticationError"
        case let .unexpectedError(message: message):
            message
        case let .unexpectedResponse(errorMessage):
            errorMessage.localizedDescription
        case .responseError:
            "responseError"
        case let .parseError(errorMessage):
            "parseError is \(errorMessage)"
        case .invalidURL:
            "Invalid URL"
        case let .httpCode(code):
            "Unexpected HTTP code: \(code)"
        case .requestError:
            "requestError"
        }
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
