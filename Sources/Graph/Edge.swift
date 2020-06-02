/// An edge is the directed link between two nodes
public protocol Edge: Codable {
    var source: String { get }
    var target: String { get }
    var value: Int { get }
}
