import SwiftUI

struct ScalableView<Content: View>: View {
    @State private var currentAmount: CGFloat = 0
    @Binding private var finalAmount: CGFloat
    let scaleRange: ClosedRange<CGFloat>
    let content: () -> Content
    
    var body: some View {
        content()
            .scaleEffect(1 + currentAmount / finalAmount)
            .gesture(
                TapGesture(count: 2)
                    .onEnded({ _ in
                        withAnimation {
                            self.finalAmount = self.finalAmount != 1.0 ? 1.0 : 2.0
                        }
                    }))
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        if self.finalAmount + amount - 1 >= 0 {
                            self.currentAmount = amount - 1
                        } else {
                            self.currentAmount = -self.finalAmount
                        }
                }
                .onEnded { _ in
                    self.finalAmount = (self.finalAmount + self.currentAmount).clamped(to: self.scaleRange)
                    self.currentAmount = 0
                }
        )
    }
    
    public init(initialScale: Binding<CGFloat>, scaleRange: ClosedRange<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self._finalAmount = initialScale
        self.scaleRange = scaleRange
        self.content = content
    }
}

extension View {
    func scalable(initialScale: Binding<CGFloat>, scaleRange: ClosedRange<CGFloat> = CGFloat(0.5)...10.0) -> some View {
        ScalableView(initialScale: initialScale, scaleRange: scaleRange) {
            self
        }
    }
}

struct ScalableView_Previews: PreviewProvider {
    @State static var scale: CGFloat = 1
    static var previews: some View {
        ScalableView(initialScale: $scale, scaleRange: CGFloat(0.2)...4.0) {
            Text("Test Text")
        }
    }
}
