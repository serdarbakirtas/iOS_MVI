import SwiftUI

struct ProfileInfo: View {
    let githubUser: GitHubUser

    var body: some View {
        VStack(spacing: 8) {
            Text(githubUser.name)
                .font(.montserratBold(size: 20))
                .foregroundColor(.cPrimary)

            if let bio = githubUser.bio {
                Text(bio)
                    .font(.montserrat(size: 16))
                    .foregroundColor(.cDark)
            }

            Divider()

            if let location = githubUser.location {
                HStack(spacing: 8) {
                    Asset.Icons.location.imageView
                        .resizable()
                        .frame(width: 14, height: 18)
                        .foregroundColor(.cDark)
                    Text(location)
                        .font(.montserrat(size: 16))
                        .foregroundColor(.cDark)
                }
            }

            Divider()

            HStack(spacing: 16) {
                VStack(spacing: 4) {
                    Text("\(githubUser.followers)")
                        .font(.montserratSemiBold(size: 24))
                        .foregroundColor(.cPrimary)
                    Text("Followers")
                        .font(.montserrat(size: 16))
                        .foregroundColor(.cDark)
                }
                VStack(spacing: 4) {
                    Text("\(githubUser.following)")
                        .font(.montserratSemiBold(size: 24))
                        .foregroundColor(.cPrimary)
                    Text("Following")
                        .font(.montserrat(size: 16))
                        .foregroundColor(.cDark)
                }
            }
        }
        .padding(EdgeInsets(top: 128, leading: 0, bottom: 16, trailing: 0))
    }
}

#Preview {
    ProfileView(feature: ProfileFeature())
}
