#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

/// Encapsulates the right hand expression of a layout equation.
struct Expression<A> where A:Anchor {
    var anchor: A?
    var constant: CGFloat
    var multiplier: CGFloat
    var priority: UILayoutPriority
    var activity: Activity
    
    internal init(anchor: A? = nil, multiplier: CGFloat = 1.0, constant: CGFloat, priority: UILayoutPriority = .required, activity: Activity = .default) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
        self.activity = activity
    }
    
    /// Sets the activity property conforming to the inherintance properties.
    ///
    /// If `activity` is `.default`, the previous value is respected.
    internal func setting(activity: Activity) -> Expression<A> {
        if case .default = activity { return self }
        var result = self
        result.activity = activity
        return result
    }
}
