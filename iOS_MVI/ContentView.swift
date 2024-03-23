import SwiftUI

struct ContentView: View {
    // Network connection changes are not consistently detected in the Simulator.
    // It's suggested to test on a real device.
    @State private var networkMonitor = NetworkMonitor()

    var body: some View {
        switch networkMonitor.networkStatus {
        case .connected:
            tabbarView
        case .disconnected:
            contentUnavailableView
        }
    }
}

// MARK: - Child views

extension ContentView {
    private var tabbarView: some View {
        TabbarView()
    }

    private var contentUnavailableView: some View {
        ContentUnavailableView(
            "No Internet Connection",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
}
