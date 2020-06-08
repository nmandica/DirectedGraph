import SwiftUI

class Screen {
    public static var bounds: CGRect {
        #if canImport(UIKit)
        return UIScreen.main.bounds
        #else
        return NSScreen.main?.frame ?? CGRect()
        #endif
    }
}
