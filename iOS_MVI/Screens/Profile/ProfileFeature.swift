final class ProfileFeature {
    @Injected(\.githubRepositoryProvider) var githubRepository: GithubRepository

    // Intent Definition
    enum Intent {
        case viewAppeared
    }

    var viewState = ProfileViewState()

    // Intent Handling
    func reduce(intent: Intent) async {
        switch intent {
        case .viewAppeared:
            await fetchTransactionList()
        }
    }
}

// MARK: - Private functions

extension ProfileFeature {
    private func fetchTransactionList() async {
        do {
            guard let result = try await githubRepository.fetchProfile() else { return }
            viewState.requestState = .succeeded(result)
            Logger.debug(result)
        } catch {
            viewState.requestState = .failed(error)
            Logger.error(error)
        }
    }
}
