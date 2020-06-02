import SwiftUI

public struct DefaultNodeView: View {
    @State private var size: CGSize = .zero
    private let id: String
    private let color: Color
    
    init(node: SimpleNode, palette: Palette) {
        id = node.id
        color = palette.color(for: node.group)
    }
    
    public var body: some View {
        ZStack {
            Ellipse()
                .foregroundColor(color)
                .frame(width: max(size.width, size.height), height: size.height)
            
            Text(id)
                .padding(10)
                .sizeReader($size)
                .colorInvert()
                .shadow(radius: 1)
        }
    }
}

struct DefaultNodeView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultNodeView(node: SimpleNode(id: "A2", group: 0), palette: Palette(colorCount: 1))
    }
}
