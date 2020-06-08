import XCTest
@testable import DirectedGraph

class CGRectExtensionsTests: XCTestCase {
    func testCenter() {
        let rect = CGRect(origin: CGPoint(x: 10, y: 40), size: CGSize(width: 50, height: 60))
        
        let center = rect.center
        
        XCTAssertEqual(center, CGPoint(x: 35, y: 70))
    }
}
