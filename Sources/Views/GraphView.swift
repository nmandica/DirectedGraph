import SwiftUI

public struct GraphView<NodeContent: View, Graph: DirectedGraph.Graph>: View {
    @ObservedObject private var viewModel: GraphViewModel<Graph>
    @State private var currentOffset = CGSize.zero
    @State private var finalOffset = CGSize.zero
    @State private var scale: CGFloat = 1
    private let nodeContent: (Graph.NodeType) -> NodeContent
    
    public init(_ viewModel: GraphViewModel<Graph>, @ViewBuilder nodeContent: @escaping (Graph.NodeType) -> NodeContent) {
        self.viewModel = viewModel
        self.nodeContent = nodeContent
    }
    
    public var body: some View {
        let offset = finalOffset + currentOffset
        let scroll = DragGesture()
            .onChanged { gesture in
                self.currentOffset = gesture.translation / self.scale
        }
        .onEnded { _ in
            self.finalOffset = offset
            self.currentOffset = CGSize.zero
        }
        
        return ZStack {
            ForEach(viewModel.edges) { edge in
                EdgeView(viewModel: edge)
            }
            
            ForEach(viewModel.nodes) { node in
                NodeView(viewModel: node) {
                    self.nodeContent((node.node as? Graph.NodeType)!)
                }
            }
        }
        .offset(offset)
        .scaleEffect(scale)
        .contentShape(Rectangle())
        .gesture(scroll)
        .scalable(initialScale: self.$scale, scaleRange: CGFloat(0.2)...5)
        .onAppear {
            self.viewModel.startLayout()
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    private static let nodes = [
        SimpleNode(id: "1", group: 0),
        SimpleNode(id: "2", group: 0),
        SimpleNode(id: "3", group: 1),
        SimpleNode(id: "4", group: 2)]
    
    private static let edges = [
        SimpleEdge(source: "1", target: "1", value: 5),
        SimpleEdge(source: "1", target: "2", value: 5),
        SimpleEdge(source: "1", target: "3", value: 1),
        SimpleEdge(source: "3", target: "4", value: 2),
        SimpleEdge(source: "2", target: "3", value: 1)
    ]
    
    static var previews: some View {
        GraphView(GraphViewModel(SimpleGraph(nodes: nodes,
                                             edges: edges)))
    }
}

public extension GraphView where NodeContent == DefaultNodeView, Graph == SimpleGraph {
    init(_ viewModel: GraphViewModel<SimpleGraph>) {
        let count = viewModel.graphNodes.compactMap { $0.group }.countDistinct
        let palette = Palette(colorCount: count)
        self.init(viewModel) { node in
            DefaultNodeView(node: node, palette: palette)
        }
    }
}
