import Foundation

enum LogLevel: String {
    case error = "🚨"
    case debug = "✅"
    case info = "ℹ️"
}

class Logger {
    private static let dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    private static let logQueue = DispatchQueue(label: "com.example.app.logger")

    static let shared = Logger()

    private init() {}

    var logLevel: LogLevel = .debug
    var enableTimestamps = true

    private static var isLoggingEnabled: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    func log(
        level: LogLevel,
        _ message: Any,
        file: String = #file,
        line: Int = #line,
        funcName: String = #function
    ) {
        if Logger.isLoggingEnabled {
            Logger.logQueue.async {
                let fileName = URL(fileURLWithPath: file).lastPathComponent
                let timestamp = self.enableTimestamps ? Logger.getCurrentTimestamp() : ""

                let logComponents = [
                    "\(timestamp) \(level.rawValue)",
                    "File: \(fileName) ➡️ Line: \(line)",
                    "Function: \(funcName)",
                    "Message: \(message)",
                ]

                let formattedLog = Logger.formatLog(logComponents)
                print(formattedLog)
            }
        }
    }

    private static func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: Date())
    }

    private static func formatLog(_ components: [String]) -> String {
        let formattedComponents = components.joined(separator: "\n")
        return "[\n\(formattedComponents)\n]"
    }

    static func error(_ message: Any, file: String = #file, line: Int = #line, funcName: String = #function) {
        shared.log(level: .error, message, file: file, line: line, funcName: funcName)
    }

    static func debug(_ message: Any, file: String = #file, line: Int = #line, funcName: String = #function) {
        shared.log(level: .debug, message, file: file, line: line, funcName: funcName)
    }

    static func info(_ message: Any, file: String = #file, line: Int = #line, funcName: String = #function) {
        shared.log(level: .info, message, file: file, line: line, funcName: funcName)
    }
}
