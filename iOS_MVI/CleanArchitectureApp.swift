import SwiftUI
import SwiftData

@main
struct iOS_MVIApp: App {
    var body: some Scene {
        WindowGroup {
            GitHubProfileView(interactor: GithubProfileInteractor())
        }
    }
}
