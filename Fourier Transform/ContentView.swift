import SwiftUI

struct ContentView: View {
    @State private var limit: Double = 5
    
    var body: some View {
        VStack {
            RotationalGraph(rotationRate: 1, samplesPerRotation: 1000, limit: limit) { x in
                return 100 * sin(x)
            }
            .stroke(Color.red, lineWidth: 1)
            .aspectRatio(1, contentMode: .fit)
            
            Group {
                ZStack {
                    HStack {
                        Text("0.0")
                        
                        Spacer()
                        
                        Text(String(format: "%0.2f", Double.pi * 20))
                    }
                    
                    TextField("5.0", text: Binding {String(limit)} set: {
                        limit = Double($0) ?? 5.0
                    })
                    .multilineTextAlignment(.center)
                }
                
                Slider(value: $limit, in: 0...(14 * .pi))
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}
