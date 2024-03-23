import SwiftUI

struct ProfileView: View {
    @State private var feature = ProfileFeature()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    switch feature.viewState.requestState {
                    case .pending, .progressing:
                        LoadingSpinnerOverlay(color: .orange, size: 40, speed: 0.3)
                    case .succeeded:
                        VStack {
                            Text(feature.viewState.dataSource?.login ?? "")
                        }
                    case let .failed(error):
                        ErrorView(error: error as? APIError)
                    }
                }
            }
        }
        .background(.black)
        .edgesIgnoringSafeArea(.all)
        .task {
            await feature.reduce(intent: .viewAppeared)
        }
    }
}

// MARK: - Previews

#Preview {
    ProfileView()
}
