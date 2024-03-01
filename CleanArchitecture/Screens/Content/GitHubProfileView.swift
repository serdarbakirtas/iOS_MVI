import SwiftUI

struct GitHubProfileView: View {
    
    @State private var viewState: GitHubProfileViewState
    @State private var interactor: GithubProfileInteractor?

    init(interactor: GithubProfileInteractor) {
        _interactor = State(initialValue: interactor)
        _viewState = State(wrappedValue: interactor.viewState)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    switch viewState.requestState {
                    case .pending, .progressing:
                        LoadingSpinnerOverlay(color: .orange, size: 40, speed: 0.3)
                    case .succeeded:
                        VStack {
                            Text(interactor?.viewState.dataSource?.login ?? "")
                        }
                    case .failed(let error):
                        ErrorView(error: error as? APIError)
                    }
                }
            }
        }
        .background(.black)
        .edgesIgnoringSafeArea(.all)
        .task {
            await interactor?.fetchGitHubProfile()
        }
    }
}

#Preview {
    GitHubProfileView(interactor: GithubProfileInteractor())
}
