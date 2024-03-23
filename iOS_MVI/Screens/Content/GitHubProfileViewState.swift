import Foundation
import Observation

@Observable class GitHubProfileViewState {
    
    var requestState: RequestState<GetAUser, Error> = .pending
    
    var dataSource: GetAUser? {
        switch requestState {
        case .succeeded(let state):
            return state
        case .pending, .progressing, .failed(_):
            return nil
        }
    }
}
