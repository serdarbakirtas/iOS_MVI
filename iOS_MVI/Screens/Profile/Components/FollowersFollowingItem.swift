import SwiftUI

struct FollowersFollowingItem: View {
    let value: Int
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.montserratSemiBold(size: 30))
                .foregroundColor(.cPrimary)
            Text(label)
                .font(.montserratLight(size: 12))
                .foregroundColor(.cDark)
        }
    }
}

#Preview {
    FollowersFollowingItem(value: 0, label: "followers")
}
