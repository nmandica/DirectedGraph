import XCTest
import SwiftUI
import ViewInspector
@testable import DirectedGraph

class EdgeViewTests: XCTestCase {
    private let nodeViewModel1 = NodeViewModel(SimpleNode(id: "1", group: 3))
    private let nodeViewModel2 = NodeViewModel(SimpleNode(id: "2", group: 3))
    
    func testStartAndEndPositions() throws {
        let position1 = CGPoint(x: 10, y: 20)
        let position2 = CGPoint(x: 60, y: -12)
        nodeViewModel1.position = position1
        nodeViewModel2.position = position2
        let viewModel = EdgeViewModel(source: nodeViewModel1, target: nodeViewModel2, value: 40)
        let view = makeView(viewModel)
        
        let arrow = try view.inspect().zStack().view(Arrow.self, 0).actualView()
        
        XCTAssertEqual(arrow.start, position1)
        XCTAssertEqual(arrow.end, viewModel.end)
    }
    
    func testWhenShowValueDisplayText() throws {
        let viewModel = EdgeViewModel(source: nodeViewModel1, target: nodeViewModel2, value: 40)
        viewModel.showValue = true
        let view = makeView(viewModel)
        
        let text = try view.inspect().zStack().text(1).string()
        
        XCTAssertEqual(text, "40.0")
    }
    
    func makeView(_ viewModel: EdgeViewModel) -> EdgeView {
        return EdgeView(viewModel: viewModel)
    }
}

extension EdgeView: Inspectable {
    
}

extension Arrow: Inspectable {
    
}
