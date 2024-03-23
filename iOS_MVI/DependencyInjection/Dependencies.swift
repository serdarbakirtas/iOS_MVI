import Foundation

extension InjectedValues {
    var networkProvider: APIRepo {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }
    
    var githupRepositoryProvider: GithubRepository {
        get { Self[GithubRepositoryProviderKey.self] }
        set { Self[GithubRepositoryProviderKey.self] = newValue }
    }
}

private struct NetworkProviderKey: InjectionKey {
    static var currentValue: APIRepo = API()
}

private struct GithubRepositoryProviderKey: InjectionKey {
    static var currentValue: GithubRepository = StandardGithubRepository()
}
