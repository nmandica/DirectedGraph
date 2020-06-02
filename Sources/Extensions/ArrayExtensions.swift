import Foundation

extension Array {
    var countDistinct: Int {
        NSSet(array: self).count
    }
}
