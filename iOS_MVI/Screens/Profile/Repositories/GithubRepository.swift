import Foundation

protocol GithubRepository {
    func fetchProfile() async throws -> GetAUser?
}

struct StandardGithubRepository: GithubRepository {
    @Injected(\.networkProvider) var networkProvider: APIRepo

    func fetchProfile() async throws -> GetAUser? {
        let request = GithubRepositoryRequest(apiRepo: .getProfile)
        let result = try await networkProvider.response(from: request)
        return result
    }
}
