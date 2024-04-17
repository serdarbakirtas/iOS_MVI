import SwiftUI

// MARK: - Asset Catalogs

enum Asset {
    enum TabbarIcons {
        static let home = ImageAsset(name: "TabbarIcons/car-solid")
        static let search = ImageAsset(name: "TabbarIcons/magnifying-glass-solid")
        static let map = ImageAsset(name: "TabbarIcons/map-solid")
        static let profile = ImageAsset(name: "TabbarIcons/user-solid")
    }
    
    enum Icons {
        static let location = ImageAsset(name: "Icons/location-dot-solid")
    }
}

// MARK: - Implementation Details

struct ImageAsset {
    fileprivate(set) var name: String

    typealias Image = UIImage

    var image: Image {
        let bundle = BundleToken.bundle
        let image = Image(named: name, in: bundle, compatibleWith: nil)
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }

    var imageView: SwiftUI.Image {
        .init(name, bundle: BundleToken.bundle)
    }
}

private final class BundleToken {
    static let bundle: Bundle = .init(for: BundleToken.self)
}
