import SwiftUI

struct ProfileInfoView: View {
    let githubUser: GitHubUser

    var body: some View {
        VStack(spacing: 8) {
            Text(githubUser.name)
                .font(.montserratBold(size: 20))
                .foregroundColor(.cPrimary)

            if let bio = githubUser.bio {
                Text(bio)
                    .font(.montserratLight(size:16))
                    .foregroundColor(.cDark)
            }

            Divider()

            if let location = githubUser.location {
                LocationRow(location: location)
            }

            Divider()

            FollowersFollowingRow(followers: githubUser.followers, following: githubUser.following)
        }
        .padding(.top, 128)
        .padding(.bottom, 16)
    }
}

#Preview {
    ProfileView(feature: ProfileFeature())
}
