import SwiftUI

struct ProfileView: View {
    @State private var feature: ProfileFeature
    @State private var viewState: ProfileViewState

    init(feature: ProfileFeature) {
        _feature = State(initialValue: feature)
        _viewState = State(wrappedValue: feature.viewState)
    }

    var body: some View {
        requestHandlerView
            .task {
                await feature.reduce(intent: .viewAppeared)
            }
    }
}

// MARK: - Child views

extension ProfileView {
    private var requestHandlerView: some View {
        ZStack {
            switch viewState.requestState {
            case .pending, .progressing:
                LoadingSpinnerOverlay(color: .orange, size: 40, speed: 0.3)
            case .succeeded:
                contentView
            case let .failed(error):
                ErrorView(error: error as? APIError)
            }
        }
    }

    private var contentView: some View {
        GeometryReader { geometry in
            let navigationBarHeight = geometry.safeAreaInsets.top
            ParallaxHeader(
                size: geometry.size,
                safeArea: geometry.safeAreaInsets,
                navigationBarHeight: navigationBarHeight,
                imageView: CircularImageView(imageURL: viewState.dataSource?.avatarURL)
            ) {
                if let githubUser = viewState.dataSource {
                    ProfileInfoView(githubUser: githubUser)
                }
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

// MARK: - Previews

#Preview {
    ProfileView(feature: ProfileFeature())
}
