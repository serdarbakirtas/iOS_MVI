import Foundation
import SwiftUI
import Combine

/// A loading spinner on top of a transparent overlay that is always visible.
struct LoadingSpinnerOverlay: View {

    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    let timing: Double
        
    let maxCounter: Int = 3
    @State var counter = 0
    
    let frame: CGSize
    let primaryColor: Color
    
    init(color: Color = .black, size: CGFloat = 50, speed: Double = 0.5) {
        timing = speed
        timer = Timer.publish(every: timing, on: .main, in: .common).autoconnect()
        frame = CGSize(width: size, height: size)
        primaryColor = color
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< maxCounter, id: \.hashValue) { index in
                Circle()
                    .scale(counter == index ? 1.0 : 0.5)
                    .fill(primaryColor)
            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .center)
        .onReceive(timer, perform: { _ in
            withAnimation(.linear(duration: timing)) {
                counter = counter == (maxCounter - 1) ? 0 : counter + 1
            }
        })
    }
}

/// A loading indicator that is controlled by a RequestState (only visible in `.progressing` state).
struct RequestStateLoadingSpinnerOverlay<Value, Failure>: View {

    let requestState: RequestState<Value, Failure>

    var body: some View {
        if case .progressing = requestState {
            LoadingSpinnerOverlay(color: .orange, size: 30, speed: 0.3)
        }
    }
}

#Preview {
    LoadingSpinnerOverlay(color: .orange, size: 40, speed: 0.3)
}
