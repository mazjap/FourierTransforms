import SwiftUI

struct RotationalGraph: Shape {
    let function: @Sendable (Double) -> Double
    
    // TODO: - Add rotation rate variable
    let samplesPerRotation: Int // How many times we pull a value from the function per rotation (2π radians)
    let limit: Double
    
    init(samplesPerRotation: Int = 314, limit: Double = 4 * .pi, function: @escaping @Sendable (Double) -> Double) {
        self.function = function
        self.samplesPerRotation = samplesPerRotation
        self.limit = limit
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rotations = limit / (2 * .pi)
        
        for i in 0..<Int(Double(samplesPerRotation) * rotations) {
            let rotationAngle = Double(i % samplesPerRotation) / Double(samplesPerRotation) * 2 * .pi
            let input = Double(i) / Double(samplesPerRotation)
            let output = function(input)
            
            // Transform function space
            let x = output * cos(rotationAngle)
            let y = output * sin(rotationAngle)
            
            let point = CGPoint(x: rect.midX + x, y: rect.midY + y)
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        return path
    }
}
