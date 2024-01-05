import SwiftUI
import SwiftData

@main
struct CleanArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
            GitHubProfileView(interactor: GithubProfileInteractor())
        }
    }
}
