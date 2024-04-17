import SwiftUI

struct FollowersFollowingRow: View {
    let followers: Int
    let following: Int

    var body: some View {
        HStack(spacing: 16) {
            FollowersFollowingItem(value: followers, label: "followers")
            FollowersFollowingItem(value: following, label: "following")
        }
    }
}

#Preview {
    FollowersFollowingRow(followers: 10, following: 5)
}
