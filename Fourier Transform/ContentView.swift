import SwiftUI

enum Function {
    case sin
    case cos
    case tan
    case sinh
    case cosh
    case tanh
    case asin
    case acos
    case atan
    case asinh
    case acosh
    case atanh
}

struct ContentView: View {
    @State private var limit: Double = 5
    @State private var selectedFunction: Function = .sin
    @State private var mappingFunc: @Sendable (Double) -> Double = { sin($0) }
    
    var body: some View {
        VStack {
            Picker("Function", selection: $selectedFunction) {
                Text("sin").tag(Function.sin)
                Text("cos").tag(Function.cos)
                Text("tan").tag(Function.tan)
                Text("sinh").tag(Function.sinh)
                Text("cosh").tag(Function.cosh)
                Text("tanh").tag(Function.tanh)
                Text("asin").tag(Function.asin)
                Text("acos").tag(Function.acos)
                Text("atan").tag(Function.atan)
                Text("asinh").tag(Function.asinh)
                Text("acosh").tag(Function.acosh)
                Text("atanh").tag(Function.atanh)
            }
            .onChange(of: selectedFunction) {
                switch selectedFunction {
                case .sin:
                    mappingFunc = { sin($0) }
                case .cos:
                    mappingFunc = { cos($0) }
                case .tan:
                    mappingFunc = { tan($0) }
                case .sinh:
                    mappingFunc = { sinh($0) }
                case .cosh:
                    mappingFunc = { cosh($0) }
                case .tanh:
                    mappingFunc = { tanh($0) }
                case .asin:
                    mappingFunc = { asin($0) }
                case .acos:
                    mappingFunc = { acos($0) }
                case .atan:
                    mappingFunc = { atan($0) }
                case .asinh:
                    mappingFunc = { asinh($0) }
                case .acosh:
                    mappingFunc = { acosh($0) }
                case .atanh:
                    mappingFunc = { atanh($0) }
                }
            }
            
            AdjustableRotationalGraph(limit: $limit, function: mappingFunc)
            
            AnimatedRotationalGraph(function: mappingFunc)
        }
    }
}

#Preview {
    ContentView()
}
