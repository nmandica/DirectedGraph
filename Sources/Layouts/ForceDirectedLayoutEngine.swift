import SwiftUI

/// A layout engine giving a force-directed graph
struct ForceDirectedLayoutEngine: LayoutEngine {
    private let steps = 3
    let isIncremental = true
    var viscosity: CGFloat = 20
    var friction: CGFloat = 0.7
    var springLength: CGFloat = 70
    var stiffness: CGFloat = 0.09
    var charge: CGFloat = 50
    
    func layout(from currentLayout: Layout,
                canvas: CGRect,
                edgeIndices: [[Int]]) -> Layout {
        var positions = currentLayout.items.map { $0.position }
        var velocities = currentLayout.items.map { $0.velocity }
        for _ in 1...steps {
            var forces = Array(repeating: CGPoint.zero, count: currentLayout.itemCount)
            let edges = edgeIndices.map { $0.map { positions[$0] } }
            let center = canvas.center - (positions.averagePoint() ?? .zero)
            for (index, position) in positions.enumerated() {
                forces[index] += repulsionForce(at: position, from: positions, skipIndex: index)
                forces[index] += springForce(at: position, from: edges[index])
                
                let nv = velocities[index] + forces[index]
                let d = nv.length
                
                velocities[index] = d > viscosity ? nv / d * viscosity : nv * friction
                positions[index] += center + velocities[index]
            }
        }
        
        let items = Array(zip(positions, velocities))
        return Layout(items: items)
    }
    
    private func springForce(at source: CGPoint, from targets: [CGPoint]) -> CGPoint {
        var force = CGPoint.zero
        for target in targets {
            force += springForce(at: source, from: target)
        }
        
        return force
    }
    
    private func springForce(at source: CGPoint, from target: CGPoint) -> CGPoint {
        let delta = target - source
        let length = delta.length
        let normalized = length > 0 ? delta / length : .zero
        return normalized * (length - springLength) * stiffness
    }
    
    private func repulsionForce(at point: CGPoint, from others: [CGPoint], skipIndex skippedIndex: Int) -> CGPoint {
        var force = CGPoint.zero
        for (index, other) in others.enumerated() {
            guard index != skippedIndex else { continue }
            
            let diff = point - other
            force += diff / (diff.lengthSquared + 0.00000001) * charge
        }
        
        return force
    }
}
