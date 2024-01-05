import Foundation

public enum HTTPMethod: String {
    case get
    case head
    case post
    case put
    case delete
    case connect
    case options
    case trace
    case patch
    
    var stringValue: String {
        rawValue.uppercased()
    }
}
