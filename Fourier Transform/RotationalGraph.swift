import SwiftUI

struct RotationalGraph: Shape {
    let function: @Sendable (Double) -> Double
    
    var animatableData: Double {
        get { limit }
        set { limit = newValue }
    }
    
    let rotationRate: Double // The x value at which a full rotation occurs
    let samplesPerRotation: Int // How many times we pull a value from the function per rotation
    var limit: Double // The x value at which graph drawing stops
    
    init(rotationRate: Double = 2 * .pi, samplesPerRotation: Int = 314, limit: Double = 4 * .pi, function: @escaping @Sendable (Double) -> Double) {
        self.rotationRate = rotationRate
        self.samplesPerRotation = samplesPerRotation
        self.limit = limit
        self.function = function
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let minDimension = min(rect.width, rect.height)
        let rotations = limit / rotationRate
        
        for i in 0..<Int(Double(samplesPerRotation) * rotations) {
            let rotationAngle = Double(i % samplesPerRotation) / Double(samplesPerRotation) * 2 * .pi
            let input = Double(i) / Double(samplesPerRotation)
            let output = (minDimension / 2) * function(input)
            
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
