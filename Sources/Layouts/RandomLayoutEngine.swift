import SwiftUI

/// A layout engine giving a random graph layout
struct RandomLayoutEngine: LayoutEngine {
    let isIncremental = false
    
    func layout(from currentLayout: Layout,
                canvas: CGRect,
                edgeIndices: [[Int]]) -> Layout {
        let count = currentLayout.itemCount
        let items = (0..<count).map { _ -> LayoutItem in
            let position = CGPoint(
                CGFloat.random(in: 0..<canvas.width),
                CGFloat.random(in: 0..<canvas.height)
            )
            return LayoutItem(position: position, velocity: CGPoint.zero)
        }
        
        return Layout(items: items)
    }
}
