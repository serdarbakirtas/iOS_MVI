import Foundation

struct GetAUser: Decodable {
    let login: String
    let followers: Int
    let following: Int
}
