import SwiftUI

class Screen {
    public static var size: CGSize {
        #if canImport(UIKit)
        return UIScreen.main.bounds.size
        #else
        return NSScreen.main?.frame.size ?? CGSize()
        #endif
    }
}
