/// A graph is a collection of nodes and edges between the nodes
public protocol Graph: Codable {
    associatedtype NodeType: Node
    associatedtype EdgeType: Edge
    
    var nodes: [NodeType] { get }
    var edges: [EdgeType] { get }
}
