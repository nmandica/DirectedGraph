import XCTest
@testable import DirectedGraph

class GraphViewModelTests: XCTestCase {
    func testInit() {
        let node1 = SimpleNode(id: "1", group: 3)
        let node2 = SimpleNode(id: "2", group: 3)
        let edge = SimpleEdge(source: "1", target: "2", value: 3)
        let graph = SimpleGraph(nodes: [node1, node2], edges: [edge])
        
        let graphViewModel = GraphViewModel(graph)
        
        XCTAssertEqual(graphViewModel.graphNodes.count, 2)
    }
}
