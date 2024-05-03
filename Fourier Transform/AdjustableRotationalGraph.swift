import SwiftUI

struct AdjustableRotationalGraph: View {
    @Binding private var limit: Double
    private let function: @Sendable (Double) -> Double
    
    init(limit: Binding<Double>, function: @Sendable @escaping (Double) -> Double) {
        self._limit = limit
        self.function = function
    }
    
    var body: some View {
        VStack {
            RotationalGraph(
                rotationRate: 1,
                samplesPerRotation: 1000,
                limit: limit,
                function: function
            )
            .stroke(Color.red, lineWidth: 1)
            .aspectRatio(1, contentMode: .fit)
            .padding()
            
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
    AdjustableRotationalGraph(limit: .constant(10), function: { sin($0) })
}
