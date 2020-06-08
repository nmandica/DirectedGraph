import SwiftUI

/// A way to compute a graph layout
protocol LayoutEngine {
    var isIncremental: Bool { get }
    
    func layout(from currentLayout: Layout,
                canvas: CGRect,
                edgeIndices: [[Int]]) -> Layout
}
