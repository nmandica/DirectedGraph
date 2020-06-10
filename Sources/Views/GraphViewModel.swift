import Combine
import SwiftUI

final public class GraphViewModel<Graph: DirectedGraph.Graph>: ObservableObject {
    private var timer: Timer?
    private var isSimulating: Bool { timer != nil }
    private var edgeIndices: [[Int]]
    private(set) var nodes: [NodeViewModel]
    private(set) var edges: [EdgeViewModel]
    let graphNodes: [Graph.NodeType]
    var willChange = PassthroughSubject<Void, Never>()
    
    public var layoutEngine: LayoutEngine = ForceDirectedLayoutEngine()
    
    public init(_ graph: Graph) {
        nodes = Self.buildNodes(graph)
        edges = Self.buildEdges(graph.edges, nodeViewModels: nodes)
        graphNodes = graph.nodes
        edgeIndices = Self.buildEdgeIndices(graph)
    }
    
    public func releaseNodes() {
        for node in nodes {
            node.interactive = false
        }
    }
    
    public func toggleEdgeValues() {
        for edge in edges {
            edge.showValue.toggle()
        }
    }
    
    public func toggleAutoLayout() {
        isSimulating ? stopLayout() : startLayout()
    }
    
    private static func buildNodes(_ graph: Graph) -> [NodeViewModel] {
        return graph.nodes.map { NodeViewModel($0) }
    }
    
    private static func buildEdges(_ edges: [Edge], nodeViewModels: [NodeViewModel]) -> [EdgeViewModel] {
        let nodeViewModelLookup = Dictionary(uniqueKeysWithValues: nodeViewModels.map { ($0.id, $0) })
        let viewModels: [EdgeViewModel] = edges.compactMap {
            guard let source = nodeViewModelLookup[$0.source],
                let target = nodeViewModelLookup[$0.target] else {
                    return nil
            }
            return EdgeViewModel(source: source, target: target, value: CGFloat($0.value))
        }
        
        return viewModels
    }
    
    private static func buildEdgeIndices(_ graph: Graph) -> [[Int]] {
        let nodeIndexLookup = Dictionary(uniqueKeysWithValues: graph.nodes.enumerated().map { ($0.1.id, $0.0) })
        var edgeIndices = Array(repeating: [Int](), count: graph.nodes.count)
        
        for edge in graph.edges {
            guard let a = nodeIndexLookup[edge.source],
                let b = nodeIndexLookup[edge.target] else {
                    continue
            }
            edgeIndices[a].append(b)
            edgeIndices[b].append(a)
        }
        
        return edgeIndices
    }
    
    public func startLayout() {
        guard layoutEngine.isIncremental else {
            self.computeLayout(engine: layoutEngine)
            return
        }
        
        guard !isSimulating else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.willChange.send()
            self.computeLayout(engine: self.layoutEngine)
        }
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    public func stopLayout() {
        guard isSimulating else { return }
        
        timer?.invalidate()
        timer = nil
    }
    
    private func computeLayout(engine: LayoutEngine) {
        let currentLayout = Layout(items: nodes.map {
            LayoutItem(position: $0.position, velocity: $0.velocity)
        })
        
        let layout = engine.layout(from: currentLayout,
                                   canvas: Screen.bounds,
                                   edgeIndices: edgeIndices)
        
        for (index, item) in layout.items.enumerated() {
            guard !nodes[index].interactive else { continue }
            nodes[index].position = item.position
            nodes[index].velocity = item.velocity
        }
    }
}
