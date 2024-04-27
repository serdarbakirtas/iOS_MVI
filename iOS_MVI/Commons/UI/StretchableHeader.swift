import SwiftUI

struct StretchableHeader: View {
    var image: CircularImageView
    var initialHeaderHeight: CGFloat = 200

    var body: some View {
        GeometryReader(content: { geometry in

            let minY = geometry.frame(in: .global).minY

            ZStack {
                Color.cPrimary.clipShape(CustomShape(xAxis: geometry.size.width / 2)
                )
                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 2)
                .offset(y: initialHeaderHeight)
                .frame(height: minY > 0 ? initialHeaderHeight + minY : initialHeaderHeight)

                image
                    .offset(y: minY > 0 ? ((initialHeaderHeight - 60) - (minY / 2)) : initialHeaderHeight - 60)
            }

        })
        .frame(height: initialHeaderHeight)
    }
}
