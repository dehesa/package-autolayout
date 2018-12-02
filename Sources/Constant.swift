#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

/// Type used on layout expressions to offset constraints.
protocol Constant {
    
}

extension CGFloat: Constant {
    
}

extension CGSize: Constant {
    
}

/// Edge inset that can be used to represent vertical- and leading/trailing or left/right horizontal-edges.
///
/// Positive values cause the frame to be inset (or shrunk) by the specified amount. Negative values cause the frame to be outset (or expanded) by the specified amount.
public struct EdgeInsets: Constant {
    /// The top edge inset value.
    public var top: CGFloat
    /// The first horizontal inset value.
    public var first: CGFloat
    /// The bottom edge inset value.
    public var bottom: CGFloat
    /// The second horizontal inset value.
    public var second: CGFloat
    
    /// An edge insets whose top, first, bottom, and second fields are all set to 0.
    public static let zero = EdgeInsets()
    
    /// Creates an edge inset with the given values.
    /// parameter top: The top edge inset value.
    /// parameter first: The first horizontal inset value.
    /// parameter bottom: The bottom edge inset value.
    /// parameter second: The second horizontal inset value.
    public init(_ top: CGFloat, _ first: CGFloat, _ bottom: CGFloat, _ second: CGFloat) {
        self.top = top
        self.first = first
        self.bottom = bottom
        self.second = second
    }
    
    /// Convenience initializer creating an inset with 0 on all its properties.
    public init() {
        self.init(0, 0, 0, 0)
    }
    
    /// Convenience initializer to create a direcctional edge inset.
    public init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailing: CGFloat) {
        self.init(top, leading, bottom, trailing)
    }
    
    /// Convenience initializer to create a horizontal edge inset.
    public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.init(top, left, bottom, right)
    }
}
