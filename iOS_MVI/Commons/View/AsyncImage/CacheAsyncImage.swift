import SwiftUI

struct CacheAsyncImage: View {
    let url: URL
    @State private var imageLoader = ImageLoader()

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case let .success(image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                EmptyView()
            }
        }
        .onAppear {
            Task {
                await imageLoader.loadImage(from: url)
            }
        }
    }
}
