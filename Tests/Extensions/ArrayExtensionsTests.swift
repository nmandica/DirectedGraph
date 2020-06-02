import XCTest
@testable import DirectedGraph

class ArrayExtensionsTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCountDistinct() throws {
        let array = [1, 8, 92, 1, 1, 3, 2, 90, 92, -1]
        
        let count = array.countDistinct
        
        XCTAssertEqual(count, 7)
    }
}
