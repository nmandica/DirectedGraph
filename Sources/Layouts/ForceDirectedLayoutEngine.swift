import SwiftUI

/// A layout engine giving a force-directed graph
public struct ForceDirectedLayoutEngine: LayoutEngine {
    private let steps = 3
    public let isIncremental = true
    public var viscosity: CGFloat = 20
    public var friction: CGFloat = 0.7
    public var springLength: CGFloat = 70
    public var stiffness: CGFloat = 0.09
    public var charge: CGFloat = 50
    public var gravitationalConstant: CGFloat = 20
    public var shieldDistanceSquared: CGFloat = 250000
    
    public init() { }
    
    public func layout(from layout: Layout, canvas: CGRect, edgeIndices: [[Int]]) -> Layout {
        var positions = layout.items.map { $0.position }
        var velocities = layout.items.map { $0.velocity }
        for _ in 1...steps {
            var forces = Array(repeating: CGPoint.zero, count: layout.itemCount)
            let edges = edgeIndices.map { $0.map { positions[$0] } }
            let center = canvas.center - (positions.averagePoint() ?? .zero)
            for (index, position) in positions.enumerated() {
                forces[index] += repulsionForce(at: position, from: positions, skipIndex: index)
                forces[index] += springForce(at: position, from: edges[index])
                forces[index] += centralForce(at: position, from: canvas.center)
                
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
            let diffSquared = diff.lengthSquared
            guard diffSquared < shieldDistanceSquared else {
                continue
            }
            force += diff / (diffSquared + 0.00000001) * charge
        }
        
        return force
    }
    
    private func centralForce(at point: CGPoint, from center: CGPoint) -> CGPoint {
        let diff = center - point
        let dist = diff.lengthSquared
        return dist > shieldDistanceSquared  ? diff / dist * gravitationalConstant : .zero
    }
}
