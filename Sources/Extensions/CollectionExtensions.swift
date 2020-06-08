import SwiftUI

extension Collection where Element == CGPoint {
    func averagePoint() -> CGPoint? {
        guard !isEmpty else {
            return nil
        }
        
        return reduce(.zero, +) / CGFloat(count)
    }
}
