import SwiftUI

class ImageLoader: Observable {
    var image: UIImage?

    private var cache = NSCache<NSURL, UIImage>()

    func loadImage(from url: URL) async {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            image = cachedImage
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            async let downloadedImage = UIImage(data: data)
            guard let image = await downloadedImage else { return }

            cache.setObject(image, forKey: url as NSURL)
            self.image = image
        } catch {
            Logger.error("Failed to load image: \(error)")
        }
    }
}
