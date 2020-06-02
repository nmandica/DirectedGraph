import XCTest
@testable import DirectedGraph

class NodeViewModelTests: XCTestCase {
    func testInit() {
        let node = SimpleNode(id: "2", group: 3)
        
        let nodeViewModel = NodeViewModel(node)
        
        XCTAssertEqual(nodeViewModel.id, "2")
        XCTAssertEqual(nodeViewModel.position, .zero)
        XCTAssertEqual(nodeViewModel.velocity, .zero)
        XCTAssertEqual(nodeViewModel.size, .zero)
    }
}
