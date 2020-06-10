import XCTest
import SwiftUI
import ViewInspector
@testable import DirectedGraph

class NodeViewTests: XCTestCase {
    private let viewModel = NodeViewModel(SimpleNode(id: "2", group: 3))
    
    func testInit() throws {
        let expectedText = "Test"
        let view = NodeView(viewModel: viewModel) {
            Text(expectedText)
        }
        
        let text = try view.inspect().view(SizeReader<Text>.self).zStack().text(0).string()
        
        XCTAssertEqual(text, expectedText)
    }
    
    func testPosition() throws {
        let expectedPosition = CGPoint(x: 1, y: 10)
        viewModel.position = expectedPosition
        let view = makeView(viewModel)
        
        let position = try view.inspect().view(SizeReader<Text>.self).position()
        
        XCTAssertEqual(position, expectedPosition)
    }
    
    func testDoubleTapToggleInteractive() throws {
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
