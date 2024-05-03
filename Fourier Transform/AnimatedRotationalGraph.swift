import SwiftUI

struct AnimatedRotationalGraph: View {
    @State private var progress: Double = 0
    
    private let limit: Double = 14 * .pi
    private let step: Double = 0.01
    private let rotation: Double = 1
    private let function: @Sendable (Double) -> Double
    
    init(function: @Sendable @escaping (Double) -> Double = { sin($0) }) {
        self.function = function
    }
    
    var body: some View {
        RotationalGraph(
            rotationRate: rotation,
            samplesPerRotation: Int(rotation / step),
            limit: limit,
            function: function
        )
        .trim(from: 0, to: progress)
        .stroke(Color.red, lineWidth: 1)
        .aspectRatio(1, contentMode: .fit)
        .padding()
        .task {
            startAnimating()
        }
    }
    
    private func startAnimating() {
        withAnimation(.linear(duration: 50).repeatForever(autoreverses: true)) {
            progress = 1
        }
    }
}

#Preview {
    AnimatedRotationalGraph()
}
