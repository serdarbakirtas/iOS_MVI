import SwiftUI

struct CircularImageView: View {
    let imageURL: URL?

    var body: some View {
        AsyncImage(url: imageURL)
            .frame(width: 160, height: 160)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 5)
    }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularImageView(imageURL: nil)
    }
}
