import Foundation

enum LogEvent: String {
    case error = "[❌]"
    case debug = "[💬]"
}

class Logger {

    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    class func error(
        _ object: Any,
        line: Int = #line,
        column: Int = #column,
        funcName: String = #function
    ) {
        if isLoggingEnabled {
            print("\(LogEvent.error.rawValue)line: \(line) column: \(column) function name: \( funcName) -> \(object)")
        }
    }

    class func debug( _ object: Any, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            print("\(LogEvent.debug.rawValue)line: \(line) column: \(column) function name: \( funcName) -> \(object)")
        }
    }
}
