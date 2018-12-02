#if os(iOS) || os(tvOS)
import UIKit
public typealias View = UIView
#elseif os(macOS)
import Cocoa
public typealias View = NSView
#else
#error("OS not supported")
#endif

extension View {
    /// Prepares the receiver to work in autolayout.
    ///
    /// Do this before a view is added to the hierarchy.
    public func enableAutolayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Prepares the receiver to work in autolayout and executes (immediately) the given closure.
    /// - parameter autolayout: Closure typically used to define constraint for the receiving view.
    /// - parameter view: The receiving view.
    public func setConstraints(_ autolayout: (_ view: View)->()) {
        self.translatesAutoresizingMaskIntoConstraints = false
        autolayout(self)
    }
    
    /// Prepares the given parameter view to work in autolayout, adds it to the receiver view hierarchy, and executes (immediately) the given closure.
    /// - parameter view: The view to be added to the receiver view hierarchy and to be layout with "autolayout".
    /// - parameter autolayout: Closure typically used to define constraint for the receiving view.
    public func addSubview(_ view: View, autolayout: (_ view: View)->()) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        autolayout(view)
    }
    
    /// Packages the top, left, bottom, and right layout anchors into a single group.
    public var edgeAnchor: AnchorQuartet {
        return .init(top: self.topAnchor, first: self.leftAnchor, bottom: self.bottomAnchor, second: self.rightAnchor)
    }
    
    /// Packages the top, leading, bottom, and trailing layout anchors into a single group.
    public var directionalEdgeAnchor: AnchorQuartet {
        return .init(top: self.topAnchor, first: self.leadingAnchor, bottom: self.bottomAnchor, second: self.trailingAnchor)
    }
    
    /// Packages the width and height layout anchors into a single group.
    public var sizeAnchor: AnchorPair<NSLayoutDimension,NSLayoutDimension> {
        return .init(self.widthAnchor, self.heightAnchor)
    }
    
    /// Packages the center X and Y layout anchors into a single group.
    public var centerAnchor: AnchorPair<NSLayoutXAxisAnchor,NSLayoutYAxisAnchor> {
        return .init(self.centerXAnchor, self.centerYAnchor)
    }
    
    /// Packages the top and bottom layout anchors into a single group.
    public var verticalAnchor: AnchorPair<NSLayoutYAxisAnchor,NSLayoutYAxisAnchor> {
        return .init(self.topAnchor, self.bottomAnchor)
    }
    
    /// Packages the left and right layout anchors into a single group.
    public var horizontalAnchor: AnchorPair<NSLayoutXAxisAnchor,NSLayoutXAxisAnchor> {
        return .init(self.leftAnchor, self.rightAnchor)
    }
    
    /// Packages the leading and trailing layout anchors into a single group.
    public var directionalAnchor: AnchorPair<NSLayoutXAxisAnchor,NSLayoutXAxisAnchor> {
        return .init(self.leadingAnchor, self.trailingAnchor)
    }
}
