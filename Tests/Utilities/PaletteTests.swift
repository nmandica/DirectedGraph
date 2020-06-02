import XCTest
@testable import DirectedGraph

class PaletteTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testColorForIndexIsCyclic() throws {
        let palette = Palette(colorCount: 3)
        
        let colorAt0 = palette.color(for: 0)
        let colorAt3 = palette.color(for: 3)
        
        XCTAssertEqual(colorAt0, colorAt3)
    }
}
