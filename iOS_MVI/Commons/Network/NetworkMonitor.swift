import Network
import SwiftUI

enum NetworkStatus: String {
    case connected
    case disconnected
}

// Observable object for monitoring network status
@Observable class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    // Observable property to track network status
    var networkStatus: NetworkStatus = .connected
}

// MARK: - Private functions

extension NetworkMonitor {
    func startMonitoringAsync() async {
        do {
            // Start monitoring network path changes
            try await withCheckedThrowingContinuation { continuation in
                monitor.pathUpdateHandler = { [weak self] path in
                    let status: NetworkStatus = path.status == .satisfied ? .connected : .disconnected
                    self?.networkStatus = status
                }
                monitor.start(queue: queue)

                // Completion handler for the asynchronous operation
                continuation.resume(returning: ())
            }
        } catch {
            Logger.error("Error starting network monitoring: \(error)")
        }
    }
}
