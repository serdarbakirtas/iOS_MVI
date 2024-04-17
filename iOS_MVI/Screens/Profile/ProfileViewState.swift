import Observation

@Observable
class ProfileViewState {
    var requestState: RequestState<GitHubUser, Error> = .pending

    var dataSource: GitHubUser? {
        switch requestState {
        case let .succeeded(state):
            state
        case .pending, .progressing, .failed:
            nil
        }
    }
}
