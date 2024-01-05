import Foundation
import SwiftUI

final class GithubProfileInteractor {
    
    // MARK: Injected
    @Injected(\.networkProvider) var networkProvider: APIRepo
    
    // MARK: Properties
    let viewState: GitHubProfileViewState
    
    init() {
        self.viewState = GitHubProfileViewState()
    }
}

// MARK: Public functions

extension GithubProfileInteractor {
    
    func loadData() async {
        
        do {
            let result = try await networkProvider.response(
                from: StandartGithubRepository(
                    apiRepo: .getProfile
                )
            )
            self.viewState.requestState = .succeeded(result)
            Logger.debug("ExploreDetailInteractor - successfully get githup profile: \(result)")
        } catch  {
            Logger.error("ExploreDetailInteractor - unsuccessfully get githup profile")
            self.viewState.requestState = .failed(error)
        }
    }
}
