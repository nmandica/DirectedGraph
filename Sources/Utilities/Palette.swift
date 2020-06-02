import SwiftUI

/// A dynamic palette of colors
struct Palette {
    private let colorCount: Int
    private let colors: [Color]
    
    init(colorCount: Int) {
        self.colorCount = colorCount
        self.colors = Self.buildColors(colorCount)
    }
    
    func color(for index: Int) -> Color {
        return colors[index % colorCount]
    }
    
    private static func buildColors(_ count: Int) -> [Color] {
        return (0..<count).map { Self.color(for: $0, from: count) }
    }
    
    private static func color(for index: Int, from colorCount: Int) -> Color {
        return Angle(radians: Double(index) / Double(colorCount) * 2.0 * .pi).color
    }
}

extension Angle {
    var color: Color {
        Color(hue: self.radians / (2 * .pi), saturation: 1, brightness: 0.8)
    }
}
