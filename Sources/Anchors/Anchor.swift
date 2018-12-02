#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

/// Concrete types conforming to this protocol represent a layout anchor used in Autolayout.
public protocol Anchor {
    
}

extension NSLayoutAnchor: Anchor {
    
}

/// A pair of layout anchors aggregated into a meaningful group.
///
/// The order is important.
public struct AnchorPair<A1,A2>: Anchor where A1: Anchor, A2: Anchor {
    /// One of the anchors in the group.
    public let first: A1, second: A2
    /// Designated initializer setting the first and second anchors of the group.
    /// - parameter first: The first layout anchor of the group.
    /// - parameter second: The second layout anchor of the group.
    init(_ first: A1, _ second: A2) {
        (self.first, self.second) = (first, second)
    }
}

// Four layout anchors aggregated into a meaningful group.
public struct AnchorQuartet: Anchor {
    /// One of the vertical anchors in the group.
    public let top, bottom: NSLayoutYAxisAnchor
    /// One of the horizontal anchors in the group.
    public let first, second: NSLayoutXAxisAnchor
    
    /// Designated initializer setting the horizontal and verticals anchors of the group.
    /// - parameter top: The top vertical anchor.
    /// - parameter first: The first horizontal anchor.
    /// - parameter bottom: The bottom vertical anchor.
    /// - parameter second: The second horizontal anchor.
    init(top: NSLayoutYAxisAnchor, first: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, second: NSLayoutXAxisAnchor) {
        (self.top, self.bottom) = (top, bottom)
        (self.first, self.second) = (first, second)
    }
}
