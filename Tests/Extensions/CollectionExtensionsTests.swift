import XCTest
@testable import DirectedGraph

class CollectionExtensionsTests: XCTestCase {    
    func testAveragePoint() {
        let point1 = CGPoint(x: 40, y: 121)
        let point2 = CGPoint(x: 50, y: 32)
        let array = [point1, point2]
        
        let average = array.averagePoint()
        
        XCTAssertEqual(average, CGPoint(x: 45, y: 76.5))
    }
    
    func testWhenCollectionIsEmptyAveragePointReturnNil() {        
        XCTAssertNil([CGPoint]().averagePoint())
    }
}
