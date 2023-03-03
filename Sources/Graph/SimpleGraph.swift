import Foundation

public struct SimpleGraph: Graph {
    public var nodes: [SimpleNode]
    public var edges: [SimpleEdge]
    
    public init(nodes: [SimpleNode], edges: [SimpleEdge]) {
        self.nodes = nodes
        self.edges = edges
    }
}

extension SimpleGraph {
    enum Error: Swift.Error {
        case fileNotFound(String)
    }
    
    private init(jsonData: Data) throws {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Self.self, from: jsonData)
        self.init(nodes: decoded.nodes, edges: decoded.edges)
    }
    
    /**
     Create a ```Graph``` from a JSON file.
     
     # Example
     If you want to load the _graph.json_ file
     ```
     let graph = try! SimpleGraph.load(filename: "graph")
     ```
     */
    public static func load(filename: String, bundle: Bundle = Bundle.main) throws -> Self {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw Error.fileNotFound(filename)
        }
        
        let data = try Data(contentsOf: url)
        return try Self(jsonData: data)
    }
}
