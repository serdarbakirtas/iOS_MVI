import Foundation

protocol GithubRepository {
    func fetchProfile() async throws -> GetAUser?
}

struct StandardGithubRepository: GithubRepository {
    
    @Injected(\.networkProvider) var networkProvider: APIRepo
    
    func fetchProfile() async throws -> GetAUser? {
        do {
            let request = GithubRepositoryRequest(apiRepo: .getProfile)
            let result = try await networkProvider.response(from: request)
            Logger.debug("ExploreDetailInteractor - successfully get githup profile: \(result)")
            return result
        } catch  {
            Logger.error("ExploreDetailInteractor - unsuccessfully get githup profile")
            return nil
        }
    }
}
