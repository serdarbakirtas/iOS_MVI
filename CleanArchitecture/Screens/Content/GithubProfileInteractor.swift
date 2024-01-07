import Foundation
import SwiftUI

final class GithubProfileInteractor {
    
    // MARK: Injected
    @Injected(\.networkProvider) var networkProvider: APIRepo
    
    // MARK: Properties
    let viewState: GitHubProfileViewState
    
    let githubRepository: GithubRepository
    
    init(
        githubRepository: GithubRepository = StandardGithubRepository()
    ) {
        self.viewState = GitHubProfileViewState()
        self.githubRepository = githubRepository
    }
}

// MARK: Public functions

extension GithubProfileInteractor {
    
    func fetchGitHubProfile() async {
        do {
            guard let result = try await githubRepository.fetchProfile() else { return }
            viewState.requestState = .succeeded(result)
        } catch {
            viewState.requestState = .failed(error)
        }
    }
}
