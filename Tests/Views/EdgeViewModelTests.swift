import XCTest
@testable import DirectedGraph

class EdgeViewModelTests: XCTestCase {
    func testEndIsNotNaNWhenSourceAndTargetAtSamePosition() {
        let node1 = SimpleNode(id: "1", group: 3)
        let node2 = SimpleNode(id: "2", group: 3)
        let nodeViewModel1 = NodeViewModel(node1)
        let nodeViewModel2 = NodeViewModel(node2)
        nodeViewModel1.position = CGPoint(25, 40)
        nodeViewModel2.position = CGPoint(25, 40)
        
        let viewModel = EdgeViewModel(source: nodeViewModel1, target: nodeViewModel2, value: .zero)
        
        XCTAssertFalse(viewModel.end.x.isNaN)
    }
}
