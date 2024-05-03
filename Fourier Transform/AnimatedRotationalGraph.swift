import SwiftUI

struct AnimatedRotationalGraph: View {
    @State private var limit: Double = 0
    private let step: Double = 0.1
    private let finalLimit: Double = 14 * .pi
    
    var body: some View {
        VStack {
            RotationalGraph(rotationRate: 1, samplesPerRotation: 50, limit: limit) { x in
                return 100 * sin(x)
            }
            .stroke(Color.red, lineWidth: 1)
            .aspectRatio(1, contentMode: .fit)
            
            HStack {
                Text("current x:\n\(String(format: "%0.3f", limit)))")
                Spacer()
                Text("final x:\n\(String(format: "%0.3f", finalLimit))")
                Spacer()
                Text("progress:\n\(String(format: "%0.3f", limit / finalLimit))")
            }
            .monospaced()
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        }
        .task {
//            stepAnimation()
        }
    }
    
    private func stepAnimation() {
        print("Stepped")
        withAnimation(.linear(duration: 0.01)) {
            limit = min(finalLimit, limit + step)
        } completion: {
            stepAnimation()
        }
    }
}

#Preview {
    AnimatedRotationalGraph()
}
