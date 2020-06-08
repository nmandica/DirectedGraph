import SwiftUI

extension CGRect {
    @inlinable
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}
