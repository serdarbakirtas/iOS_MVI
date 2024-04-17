import SwiftUI

struct LocationRow: View {
    let location: String

    var body: some View {
        HStack(spacing: 8) {
            Asset.Icons.location.imageView
                .resizable()
                .frame(width: 14, height: 18)
                .foregroundColor(.cPrimary)

            Text(location)
                .font(.montserrat(size: 14))
                .foregroundColor(.cDark)
        }
    }
}

#Preview {
    LocationRow(location: "Berlin, Germany")
}
