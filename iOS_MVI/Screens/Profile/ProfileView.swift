import SwiftUI

struct ProfileView: View {
    @State private var feature = ProfileFeature()

    var body: some View {
        NavigationView {
            contentView
                .navigationTitle("Profile")
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(
            backgroundColor: UIColor(Color.cPrimary),
            textColor: UIColor(Color.cWhite),
            font: UIFont.boldSystemFont(ofSize: 28)
        )
        .task {
            await feature.reduce(intent: .viewAppeared)
        }
    }
}

// MARK: - Child views

extension ProfileView {
    private var contentView: some View {
        ZStack {
            VStack {
                switch feature.viewState.requestState {
                case .pending, .progressing:
                    LoadingSpinnerOverlay(color: .orange, size: 40, speed: 0.3)
                case .succeeded:
                    VStack {
                        Text(feature.viewState.dataSource?.login ?? "")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.cDark)
                    }
                case let .failed(error):
                    ErrorView(error: error as? APIError)
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ProfileView()
}
