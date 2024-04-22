import SwiftUI

actor ImageLoader: Observable {
    private var image: UIImage?
    private let cache = NSCache<NSURL, UIImage>()
    private var currentTask: Task<Void, Error>?

    func loadImage(from url: URL) async {
        // Cancel any ongoing task before starting a new one
        currentTask?.cancel()

        // Check cache
        if let cachedImage = await cacheObject(forKey: url) {
            image = cachedImage
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let downloadedImage = UIImage(data: data)
            guard let image = downloadedImage else { return }

            cache.setObject(image, forKey: url as NSURL)
            self.image = image
        } catch {
            // Handle cancellation error separately
            if let cancellationError = error as? CancellationError {
                Logger.info("Image loading cancelled.")
            } else {
                Logger.error("Failed to load image: \(error)")
            }
        }
    }

    private func cacheObject(forKey key: URL) async -> UIImage? {
        cache.object(forKey: key as NSURL)
    }

    func cancelLoad() {
        currentTask?.cancel()
    }
}
