import SwiftUI

extension Collection where Element == CGPoint {
    func averagePoint() -> CGPoint? {
        guard count != 0 else {
            return nil
        }
        
        return reduce(.zero, +) / CGFloat(count)
    }
}
