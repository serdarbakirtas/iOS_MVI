import SwiftUI

struct ProfileView: View {
    @State private var feature: ProfileFeature
    @State private var viewState: ProfileViewState

    init(feature: ProfileFeature) {
        _feature = State(initialValue: feature)
        _viewState = State(wrappedValue: feature.viewState)
    }

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
                switch viewState.requestState {
                case .pending, .progressing:
                    LoadingSpinnerOverlay(color: .orange, size: 40, speed: 0.3)
                case .succeeded:
                    VStack {
                        Text(viewState.dataSource?.login ?? "")
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
    ProfileView(feature: ProfileFeature())
}
