import XCTest
@testable import DirectedGraph

class ComparableExtensionsTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testClampedWhenSmallerReturnMinValue() throws {
        let minValue = 3
        let maxValue = 10
        let range = minValue...maxValue
        
        let clamped = 2.clamped(to: range)
        
        XCTAssertEqual(clamped, minValue)
    }
    
    func testClampedWhenBiggerReturnMaxValue() throws {
        let minValue = 1.2
        let maxValue = 9.5
        let range = minValue...maxValue
        
        let clamped = 9.6.clamped(to: range)
        
        XCTAssertEqual(clamped, maxValue)
    }
    
    func testClampedWhenInRangeReturnValue() throws {
        let minValue = -1
        let maxValue = 6
        let value = 5
        let range = minValue...maxValue
        
        let clamped = value.clamped(to: range)
        
        XCTAssertEqual(clamped, value)
    }
}
