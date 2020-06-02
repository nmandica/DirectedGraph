import SwiftUI
import Combine

final class EdgeViewModel: ObservableObject, Identifiable {
    let id: String
    let value: CGFloat
    @Published var source: NodeViewModel
    @Published var target: NodeViewModel
    @Published var showValue = false
    var sourceCancellable: AnyCancellable?
    var targetCancellable: AnyCancellable?
    
    init(source: NodeViewModel, target: NodeViewModel, value: CGFloat) {
        self.id = "\(source.id)-\(target.id)"
        self.source = source
        self.target = target
        self.value = value
        
        sourceCancellable = source.objectWillChange.sink { (_) in
            self.objectWillChange.send()
        }
        targetCancellable = target.objectWillChange.sink { (_) in
            self.objectWillChange.send()
        }
    }
    
    var middle: CGPoint { (source.position + target.position) / 2 }
    
    var start: CGPoint {
        source.position
    }
    
    var end: CGPoint {
        let angle = atan((target.position.y - start.y) / (target.position.x - start.x)) +
            ((target.position.x - start.x) < 0 ? CGFloat(Double.pi) : 0)
        let suppr = CGPoint(x: cos(angle) * (target.size.width + value) * 0.5, y: sin(angle) * (target.size.height + value) * 0.5)
        return target.position - suppr
    }
}
