import SwiftUI

public struct Layout {
    let items: [LayoutItem]
    let itemCount: Int
    
    init(items: [LayoutItem]) {
        self.items = items
        self.itemCount = items.count
    }
    
    init(items: [(position: CGPoint, velocity: CGPoint)]) {
        self.init(items: items.map {
            LayoutItem(position: $0.position, velocity: $0.velocity)
        })
    }
}
