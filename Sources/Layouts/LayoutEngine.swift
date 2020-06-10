import SwiftUI

/// A way to compute a graph layout
public protocol LayoutEngine {
    var isIncremental: Bool { get }
    
    func layout(from layout: Layout,
                canvas: CGRect,
                edgeIndices: [[Int]]) -> Layout
}
