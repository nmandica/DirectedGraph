import SwiftUI

/// A layout engine giving a circular graph
public struct CircularLayoutEngine: LayoutEngine {
    public let isIncremental = false
    
    public init() { }
    
    public func layout(from layout: Layout, canvas: CGRect, edgeIndices: [[Int]]) -> Layout {
        let count = layout.itemCount
        let radius = min(canvas.width, canvas.height) * 0.4
        let center = canvas.center
        let delta = 2 * CGFloat.pi / CGFloat(count)
        
        var angle = CGFloat(0)
        let items = (0..<count).map { _ -> LayoutItem in
            let position = center + CGPoint(cos(angle), sin(angle)) * radius
            angle += delta
            return LayoutItem(position: position, velocity: CGPoint.zero)
        }
        
        return Layout(items: items)
    }
}
