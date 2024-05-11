import Foundation

protocol GithubRepository {
    func fetchProfile() async throws -> GitHubUser?
}

struct StandardGithubRepository: GithubRepository {
    @Dependency(\.networkProvider) var networkProvider

    func fetchProfile() async throws -> GitHubUser? {
        let request = GithubRepositoryRequest(apiRepo: .getProfile)
        let result = try await networkProvider.response(from: request)
        return result
    }
}
