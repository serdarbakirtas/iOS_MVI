import Foundation

// MARK: - Dependency Injection

extension DependencyValues {
    // MARK: Network Provider

    var networkProvider: APIRepo {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }

    // MARK: GitHub Repository Provider

    var githubRepository: GithubRepository {
        get { Self[GithubRepositoryKey.self] }
        set { Self[GithubRepositoryKey.self] = newValue }
    }
}

// MARK: - Injection Keys

private struct NetworkProviderKey: InjectionKey {
    static var currentValue: APIRepo = API()
}

private struct GithubRepositoryKey: InjectionKey {
    static var currentValue: GithubRepository = StandardGithubRepository()
}
