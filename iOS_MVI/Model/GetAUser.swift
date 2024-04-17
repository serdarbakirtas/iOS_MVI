import Foundation

struct GitHubUser: Decodable {
    let login: String
    let id: Int
    let nodeID: String?
    let avatarURL: URL
    let gravatarID: String
    let url: URL
    let htmlURL: URL
    let followersURL: URL
    let followingURL: URL
    let gistsURL: URL
    let starredURL: URL
    let subscriptionsURL: URL
    let organizationsURL: URL
    let reposURL: URL
    let eventsURL: URL
    let receivedEventsURL: URL
    let type: String
    let siteAdmin: Bool
    let name: String
    let company: String?
    let blog: URL?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case login, id, nodeID = "node_id", avatarURL = "avatar_url", gravatarID = "gravatar_id", url, htmlURL = "html_url", followersURL = "followers_url", followingURL = "following_url", gistsURL = "gists_url", starredURL = "starred_url", subscriptionsURL = "subscriptions_url", organizationsURL = "organizations_url", reposURL = "repos_url", eventsURL = "events_url", receivedEventsURL = "received_events_url", type, siteAdmin = "site_admin", name, company, blog, location, email, hireable, bio, twitterUsername = "twitter_username", publicRepos = "public_repos", publicGists = "public_gists", followers, following, createdAt = "created_at", updatedAt = "updated_at"
    }
}
