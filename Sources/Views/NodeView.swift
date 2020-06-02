import Foundation
import SwiftUI

struct NodeView<Content: View>: View {
    @ObservedObject private var viewModel: NodeViewModel
    private let content: () -> Content
    @State private var delta: CGPoint = .zero
    
    public init(viewModel: NodeViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
    }
    
    var body: some View {
        content()
            .sizeReader($viewModel.size)
            .position(viewModel.position)
            .gesture(drag)
            .onTapGesture(count: 2) {
                self.viewModel.interactive.toggle()
        }
    }
    
    private var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                if self.delta == .zero {
                    self.delta = value.location - self.viewModel.position
                }
                self.viewModel.interactive = true
                self.viewModel.position = value.location - self.delta
                self.viewModel.velocity = .zero
        }
        .onEnded { _ in
            self.viewModel.interactive = true
            self.delta = .zero
        }
    }
}
