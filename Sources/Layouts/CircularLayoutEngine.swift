import SwiftUI

/// A layout engine giving a circular graph
struct CircularLayoutEngine: LayoutEngine {
    let isIncremental = false
    
    func layout(from currentLayout: Layout,
                canvasSize: CGSize,
                edgeIndices: [[Int]]) -> Layout {
        let count = currentLayout.itemCount
        let radius = min(canvasSize.width, canvasSize.height) * 0.4
        let center = CGPoint(canvasSize.width * 0.5, canvasSize.height * 0.5)
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
