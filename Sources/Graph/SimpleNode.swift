public struct SimpleNode: Node {
    public var id: String
    public var group: Int
    
    public init(id: String, group: Int) {
        self.id = id
        self.group = group
    }
}
