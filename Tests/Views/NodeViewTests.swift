import XCTest
import SwiftUI
import ViewInspector
@testable import DirectedGraph

class NodeViewTests: XCTestCase {
    func testInit() throws {
        let expectedText = "Test"
        let node = SimpleNode(id: "2", group: 3)
        let viewModel = NodeViewModel(node)
        let view = NodeView(viewModel: viewModel) {
            Text(expectedText)
        }
        
        let text = try view.inspect().view(SizeReader<Text>.self).zStack().text(0).string()
        
        XCTAssertEqual(text, expectedText)
    }
    
    func testPosition() throws {
        let expectedPosition = CGPoint(x: 1, y: 10)
        let node = SimpleNode(id: "2", group: 3)
        let viewModel = NodeViewModel(node)
        viewModel.position = expectedPosition
        let view = makeView(viewModel)
        
        let position = try view.inspect().view(SizeReader<Text>.self).position()
        
        XCTAssertEqual(position, expectedPosition)
    }
    
    func testDoubleTapToggleInteractive() throws {
        let node = SimpleNode(id: "2", group: 3)
        let viewModel = NodeViewModel(node)
        let view = makeView(viewModel)
        
        try view.callOnTapGesture()
        
        XCTAssertEqual(viewModel.interactive, true)
        
        try view.callOnTapGesture()
        
        XCTAssertEqual(viewModel.interactive, false)
    }
    
    func makeView(_ viewModel: NodeViewModel) -> NodeView<Text> {
        return NodeView(viewModel: viewModel) {
            Text("Test")
        }
    }
}

extension NodeView: Inspectable where Content == Text {
    func callOnTapGesture() throws {
        try inspect().view(SizeReader<Text>.self).callOnTapGesture()
    }
}

extension SizeReader: Inspectable where Content == Text {
    
}
