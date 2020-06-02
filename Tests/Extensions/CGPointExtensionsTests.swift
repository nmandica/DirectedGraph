import XCTest
@testable import DirectedGraph

class CGPointExtensionsTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddition() throws {
        let point1 = CGPoint(x: 40, y: 121)
        let point2 = CGPoint(x: 50, y: 32)
        
        let added = point1 + point2
        
        XCTAssertEqual(added, CGPoint(x: 90, y: 153))
    }
}
