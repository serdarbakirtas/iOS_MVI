import Observation

@Observable
class ProfileViewState {
    var requestState: RequestState<GetAUser, Error> = .pending

    var dataSource: GetAUser? {
        switch requestState {
        case let .succeeded(state):
            state
        case .pending, .progressing, .failed:
            nil
        }
    }
}
