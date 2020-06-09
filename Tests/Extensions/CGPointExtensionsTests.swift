import XCTest
@testable import DirectedGraph

class CGPointExtensionsTests: XCTestCase {
    func testAddition() {
        let point1 = CGPoint(x: 40, y: 121)
        let point2 = CGPoint(x: 50, y: 32)
        
        let added = point1 + point2
        
        XCTAssertEqual(added, CGPoint(x: 90, y: 153))
    }
    
    func testSubtraction() {
        let point1 = CGPoint(x: 50, y: 1)
        let point2 = CGPoint(x: 10, y: 32)
        
        let substracted = point1 - point2
        
        XCTAssertEqual(substracted, CGPoint(x: 40, y: -31))
    }
    
    func testOpposite() {
        let point = CGPoint(x: 50, y: -21)
        
        let opposite = -point
        
        XCTAssertEqual(opposite, CGPoint(x: -50, y: 21))
    }
    
    func testAdditionCompoundAssignment() {
        var point1 = CGPoint(x: 40, y: 121)
        let point2 = CGPoint(x: 50, y: 32)
        
        point1 += point2
        
        XCTAssertEqual(point1, CGPoint(x: 90, y: 153))
    }
    
    func testFloatMultiplication() {
        let point = CGPoint(x: 50, y: 2)
        
        let multiplied = point * 3
        
        XCTAssertEqual(multiplied, CGPoint(x: 150, y: 6))
    }
    
    func testFloatDivision() {
        let point = CGPoint(x: 50, y: 2)
        
        let divided = point / 2
        
        XCTAssertEqual(divided, CGPoint(x: 25, y: 1))
    }
    
    func testLengthSquared() {
        let point = CGPoint(x: 5, y: 4)
        
        let lengthSquared = point.lengthSquared
        
        XCTAssertEqual(lengthSquared, 41)
    }
    
    func testLength() {
        let point = CGPoint(x: 3, y: 4)
        
        let length = point.length
        
        XCTAssertEqual(length, 5)
    }
    
    func testAngle() {
        let point = CGPoint(x: 1, y: 1)
        XCTAssertEqual(point.angle, .pi / 4.0)
    }
    
    func testAngleWhenZeroReturnZero() {
        XCTAssertEqual(CGPoint.zero.angle, .zero)
    }
}
