import XCTest
@testable import DirectedGraph

class EdgeViewModelTests: XCTestCase {
    private let sourceNode = NodeViewModel(SimpleNode(id: "1", group: 3))
    private let targetNode = NodeViewModel(SimpleNode(id: "2", group: 3))
    private var cancellable: Any?
    
    func testEndIsNotNaNWhenSourceAndTargetAtSamePosition() {
        sourceNode.position = CGPoint(25, 40)
        targetNode.position = CGPoint(25, 40)
        
        let viewModel = EdgeViewModel(source: sourceNode, target: targetNode, value: .zero)
        
        XCTAssertFalse(viewModel.end.x.isNaN)
    }
    
    func testSourceChangeTriggerEdgeChange() {
        let viewModel = EdgeViewModel(source: sourceNode, target: targetNode, value: 40)
        var hasChanged = false
        cancellable = viewModel.objectWillChange.sink { _ in
            hasChanged = true
        }
        
        sourceNode.position.x += 2
        
        XCTAssertTrue(hasChanged)
    }
    
    func testTargetChangeTriggerEdgeChange() {
        let viewModel = EdgeViewModel(source: sourceNode, target: targetNode, value: 40)
        var hasChanged = false
        cancellable = viewModel.objectWillChange.sink { _ in
            hasChanged = true
        }
        
        targetNode.position.x += 2
        
        XCTAssertTrue(hasChanged)
    }
}
