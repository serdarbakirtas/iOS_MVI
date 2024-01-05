import SwiftUI

struct ErrorView: View {
    
    var error: APIError?
    
    var body: some View {
        
        VStack(spacing: 16) {
            Text("Error occurred! Try again")
            Text(error?.localizedDescription ?? "")
        }.padding()
    }
}

#Preview {
    ErrorView()
}
