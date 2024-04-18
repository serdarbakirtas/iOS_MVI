import SwiftUI

struct ParallaxHeader<Content>: View where Content: View {
    // Properties
    private let content: () -> Content
    private let size: CGSize
    private let safeArea: EdgeInsets
    private let imageView: CircularImageView

    @State private var offsetY: CGFloat = 0

    // Constants
    private let velocityMultiplier: CGFloat = 45
    private let animationResponse: Double = 0.55
    private let animationDampingFraction: CGFloat = 0.65

    private var headerHeight: CGFloat {
        (size.height * 0.20) + safeArea.top
    }

    private var minimumHeaderHeight: CGFloat {
        65 + safeArea.top
    }

    private var progress: CGFloat {
        max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0) // it counts 0...1
    }

    private var calculatedHeaderHeight: CGFloat {
        let totalOffset = headerHeight + offsetY
        return totalOffset < minimumHeaderHeight ? minimumHeaderHeight : totalOffset
    }

    // MARK: - Initializers

    /// - Parameters
    ///   - size: Size of geometry
    ///   - safeArea: Safe area of geometry
    ///   - ViewBuilder: It return view to impelement it under the header view
    init(
        size: CGSize,
        safeArea: EdgeInsets,
        imageView: CircularImageView,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.size = size
        self.safeArea = safeArea
        self.imageView = imageView
        self.content = content
    }

    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    header
                        .zIndex(1000)
                    content()
                }
                .id("SCROLLVIEW")
                .background {
                    ScrollDetector { offset in
                        DispatchQueue.main.async {
                            offsetY = -offset
                        }
                    } onDraggingEnd: { offset, velocity in
                        handleScrollEnd(offset, velocity, scrollProxy)
                    }
                }
            }
        }
    }
}

// MARK: - Child views

extension ParallaxHeader {
    private var header: some View {
        GeometryReader { geometry in
            ZStack {
                // Background with shape
                Color.cPrimary.clipShape(CustomShape(xAxis: geometry.size.width / 2)
                    .offset(y: calculatedHeaderHeight)
                )
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 2)

                imageView
                    .frame(height: calculatedHeaderHeight, alignment: .top)
                    .offset(y: calculatedHeaderHeight - 50)
            }
            .frame(height: calculatedHeaderHeight, alignment: .bottom)
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
    }
}

// MARK: - Private Functions

extension ParallaxHeader {
    private func handleScrollEnd(_ offset: CGFloat, _ velocity: CGFloat, _ scrollProxy: ScrollViewProxy) {
        let headerHeight = (size.height * 0.37) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let targetEnd = offset + (velocity * velocityMultiplier)

        if targetEnd < (headerHeight - minimumHeaderHeight), targetEnd > 0 {
            withAnimation(
                .interactiveSpring(
                    response: animationResponse,
                    dampingFraction: animationDampingFraction,
                    blendDuration: animationDampingFraction
                )
            ) {
                scrollProxy.scrollTo("SCROLLVIEW", anchor: .top)
            }
        }
    }
}

#Preview {
    ProfileView(feature: ProfileFeature())
}
