#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

public struct Expression<A> where A:Anchor {
    let anchor: A
    let multiplier: CGFloat
    var constant: A.Constant
    var priority: Priority
    
    init(anchor: A, multiplier: CGFloat = 1, constant: A.Constant = .init(), priority: Priority = .required) {
        self.anchor = anchor
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
    }
}
