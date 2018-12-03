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
}

extension View {
    /// Packages the left and right layout anchors into a single group.
    public var horizontalAnchor: HorizontalAnchor {
        return .init(left: self.leftAnchor, right: self.rightAnchor)
    }
    
    /// Packages the leading and trailing layout anchors into a single group.
    public var directionalAnchor: DirectionalAnchor {
        return .init(leading: self.leadingAnchor, trailing: self.trailingAnchor)
    }
    
    /// Packages the top and bottom layout anchors into a single group.
    public var verticalAnchor: VerticalAnchor {
        return .init(top: self.topAnchor, bottom: self.bottomAnchor)
    }
    
    /// Packages the center X and Y layout anchors into a single group.
    public var centerAnchor: CenterAnchor {
        return .init(x: self.centerXAnchor, y: self.centerYAnchor)
    }
    
    /// Packages the width and height layout anchors into a single group.
    public var sizeAnchor: SizeAnchor {
        return .init(width: self.widthAnchor, height: self.heightAnchor)
    }
    
    /// Packages the top, left, bottom, and right layout anchors into a single group.
    public var edgeAnchor: EdgeAnchor {
        return .init(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    /// Packages the top, leading, bottom, and trailing layout anchors into a single group.
    public var directionalEdgeAnchor: DirectionalEdgeAnchor {
        return .init(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
}
