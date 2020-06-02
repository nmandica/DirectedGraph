import SwiftUI
import Combine

final class NodeViewModel: ObservableObject, Identifiable {
    let node: Node
    let id: String
    @Published var interactive = false
    @Published var position: CGPoint
    @Published var size: CGSize
    var velocity: CGPoint
    
    init(_ node: Node) {
        self.node = node
        id = node.id
        position = .zero
        velocity = .zero
        size = .zero
    }
}
