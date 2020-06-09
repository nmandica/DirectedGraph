import SwiftUI

struct Arrow: Shape {
    private let pointerLineLength: CGFloat = 30
    private let arrowAngle = CGFloat(Double.pi / 6)
    let start: CGPoint
    let end: CGPoint
    let thickness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: start)
        path.addLine(to: end)
        
        let delta = end - start
        let angle = delta.angle
        let arrowLine1 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - angle + arrowAngle),
                                 y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - angle + arrowAngle))
        let arrowLine2 = CGPoint(x: end.x + pointerLineLength * cos(CGFloat(Double.pi) - angle - arrowAngle),
                                 y: end.y - pointerLineLength * sin(CGFloat(Double.pi) - angle - arrowAngle))
        
        path.move(to: arrowLine1)
        path.addLine(to: end)
        path.addLine(to: arrowLine2)
        
        return path.strokedPath(.init(lineWidth: thickness))
    }
}

struct Arrow_Previews: PreviewProvider {
    static let start = CGPoint(x: 80, y: 80)
    static let end = CGPoint(x: 300, y: 200)
    
    static var previews: some View {
        Arrow(start: start, end: end, thickness: 4)
    }
}
