import XCTest
import SwiftUI
import ViewInspector
@testable import DirectedGraph

class NodeViewTests: XCTestCase {
    func testInit() throws {
        let node = SimpleNode(id: "2", group: 3)
        let viewModel = NodeViewModel(node)
        let view = NodeView(viewModel: viewModel) {
            Text("Test")
        }
        
        let text = try view.inspect().view(SizeReader<Text>.self).zStack().text(0).string()
        
        XCTAssertEqual(text, "Test")
    }
    
    func testPosition() throws {
        let expectedPosition = CGPoint(x: 1, y: 10)
        let node = SimpleNode(id: "2", group: 3)
        let viewModel = NodeViewModel(node)
        viewModel.position = expectedPosition
        let view = NodeView(viewModel: viewModel) {
            Text("Test")
        }
        
        let position = try view.inspect().view(SizeReader<Text>.self).position()
        
        XCTAssertEqual(position, expectedPosition)
    }
    
    func testDoubleTapToggleInteractive() throws {
        let expectedPosition = CGPoint(x: 1, y: 10)
        let node = SimpleNode(id: "2", group: 3)
        let viewModel = NodeViewModel(node)
        viewModel.position = expectedPosition
        let view = NodeView(viewModel: viewModel) {
            Text("Test")
        }
        
        try view.inspect().view(SizeReader<Text>.self).callOnTapGesture()
        
        XCTAssertEqual(viewModel.interactive, true)
        
        try view.inspect().view(SizeReader<Text>.self).callOnTapGesture()
        
        XCTAssertEqual(viewModel.interactive, false)
    }
}

extension NodeView: Inspectable where Content == Text {
    
}

extension SizeReader: Inspectable where Content == Text {
    
}
