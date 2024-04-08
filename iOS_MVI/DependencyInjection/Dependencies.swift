import Foundation

// MARK: - Dependency Injection

extension InjectedValues {
    // MARK: Network Provider

    var networkProvider: APIRepo {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }

    // MARK: GitHub Repository Provider

    var githubRepositoryProvider: GithubRepository {
        get { Self[GithubRepositoryProviderKey.self] }
        set { Self[GithubRepositoryProviderKey.self] = newValue }
    }
}

// MARK: - Injection Keys

private struct NetworkProviderKey: InjectionKey {
    static var currentValue: APIRepo = API()
}

private struct GithubRepositoryProviderKey: InjectionKey {
    static var currentValue: GithubRepository = StandardGithubRepository()
}
