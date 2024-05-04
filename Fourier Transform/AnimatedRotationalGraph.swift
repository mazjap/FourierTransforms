import SwiftUI
import Charts

struct AnimatedRotationalGraph: View {
    @State private var progress: Double = 0
    
    private let limit: Double = 7 * .pi
    private let step: Double = 0.01
    private let rotation: Double = 1
    private let function: @Sendable (Double) -> Double
    
    init(function: @Sendable @escaping (Double) -> Double) {
        self.function = function
    }
    
    var body: some View {
        VStack {
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
            
            Chart {
                ForEach(0..<Int(limit / step), id: \.self) { i in
                    let value = Double(i) * step
                    LineMark(
                        x: .value("x", value),
                        y: .value("y", function(value))
                    )
                    .lineStyle(.init(lineWidth: 1))
                }
                
                RuleMark(x: .value("Index", limit * progress))
                    .foregroundStyle(.red)
                
                
                RectangleMark(xStart: .value("start", 0), xEnd: .value("end", limit * progress))
                    .foregroundStyle(.red.opacity(0.1))
            }
            .chartXScale(domain: [0, limit])
            .frame(height: 100)
            .padding(.horizontal)
        }
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
    AnimatedRotationalGraph(function: { abs(cos($0)) })
}
