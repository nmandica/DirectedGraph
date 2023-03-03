public struct SimpleEdge: Edge {
    public var source: String
    public var target: String
    public var value: Int
    
    public init(source: String, target: String, value: Int) {
        self.source = source
        self.target = target
        self.value = value
    }
}
