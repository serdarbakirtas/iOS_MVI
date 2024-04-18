import SwiftUI

struct LoadingSpinnerOverlay: View {
    var body: some View {
        ActivityIndicator(style: .medium, isAnimating: .constant(true))
            .accessibility(identifier: "loadingview")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct RequestStateLoadingSpinnerOverlay<Value, Failure>: View {
    let requestState: RequestState<Value, Failure>

    var body: some View {
        if case .pending = requestState {
            LoadingSpinnerOverlay()
        }
    }
}

#Preview {
    LoadingSpinnerOverlay()
}
