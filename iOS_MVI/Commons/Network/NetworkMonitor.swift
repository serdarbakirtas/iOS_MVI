import Network
import SwiftUI

enum NetworkStatus: String {
    case connected
    case disconnected
}

@Observable class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    // Observable property to track network status
    var networkStatus: NetworkStatus = .connected

    init() {
        startMonitoring()
    }
}

// MARK: - Private functions

extension NetworkMonitor {
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }

            DispatchQueue.main.async {
                self.updateNetworkStatus(for: path)
            }
        }
        monitor.start(queue: queue)
    }

    // Method to update network status based on path update
    private func updateNetworkStatus(for path: NWPath) {
        networkStatus = path.status == .satisfied ? .connected : .disconnected
    }
}
