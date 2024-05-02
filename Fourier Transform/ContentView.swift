import SwiftUI

struct ContentView: View {
    @State private var limit: Double = 5
    
    var body: some View {
        VStack {
            RotationalGraph(samplesPerRotation: 300, limit: limit) { x in
                return 100 * sin(x * x)
            }
            .stroke(Color.red, lineWidth: 1)
            .aspectRatio(1, contentMode: .fit)
            
            Slider(value: $limit, in: 0...100)
                .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
