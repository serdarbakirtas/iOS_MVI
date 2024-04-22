import SwiftUI

struct ContentView: View {
    @State private var networkMonitor = NetworkMonitor()

    var body: some View {
        Group {
            switch networkMonitor.networkStatus {
            case .connected:
                tabbarView
            case .disconnected:
                contentUnavailableView
            }
        }
        .onAppear {
            Task {
                await networkMonitor.startMonitoringAsync()
            }
        }
    }

    // MARK: - Child views

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
