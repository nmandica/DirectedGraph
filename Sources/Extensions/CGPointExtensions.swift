import SwiftUI

extension CGPoint {
    @inlinable
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
    
    @inlinable
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    @inlinable
    static prefix func -(point: CGPoint) -> CGPoint {
        return CGPoint(-point.x, -point.y)
    }
    
    @inlinable
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return lhs + (-rhs)
    }
    
    @inlinable
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    
    @inlinable
    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(lhs.x * rhs, lhs.y * rhs)
    }
    
    @inlinable
    static func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(lhs.x / rhs, lhs.y / rhs)
    }
    
    @inlinable
    var lengthSquared: CGFloat {
        return x * x + y * y
    }
    
    @inlinable
    var length: CGFloat {
        return lengthSquared.squareRoot()
    }
}
