import SwiftUI

struct CacheAsyncImage: View {
    let url: URL
    @StateObject private var imageLoader = ImageLoader()

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
            imageLoader.loadImage(from: url)
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var cache = NSCache<NSURL, UIImage>()

    func loadImage(from url: URL) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data, let downloadedImage = UIImage(data: data) else { return }
            self.cache.setObject(downloadedImage, forKey: url as NSURL)
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }.resume()
    }
}
