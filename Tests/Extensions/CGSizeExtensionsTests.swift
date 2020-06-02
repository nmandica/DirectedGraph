import XCTest
@testable import DirectedGraph

class CGSizeExtensionsTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddition() throws {
        let size1 = CGSize(width: 40, height: 121)
        let size2 = CGSize(width: 50, height: 32)
        
        let added = size1 + size2
        
        XCTAssertEqual(added, CGSize(width: 90, height: 153))
    }
    
    func testDivision() throws {
        let size = CGSize(width: 40, height: 121)
        
        let divided = size / 10
        
        XCTAssertEqual(divided, CGSize(width: 4, height: 12.1))
    }
}
