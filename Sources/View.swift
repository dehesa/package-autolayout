#if canImport(UIKit)
import UIKit
public typealias LayoutView = UIView
#elseif canImport(Cocoa)
import Cocoa
public typealias LayoutView = NSView
#else
#error("OS not supported")
#endif

extension LayoutView {
    /// Prepares the receiver to work in autolayout.
    ///
    /// Do this before a view is added to the hierarchy.
    public func enableAutolayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Prepares the receiver to work in autolayout and executes (immediately) the given closure.
    /// - parameter autolayout: Closure typically used to define constraint for the receiving view.
    /// - parameter view: The receiving view.
    public func setConstraints(_ autolayout: (_ view: LayoutView)->()) {
        self.translatesAutoresizingMaskIntoConstraints = false
        autolayout(self)
    }
    
    /// Prepares the given parameter view to work in autolayout, adds it to the receiver view hierarchy, and executes (immediately) the given closure.
    /// - parameter view: The view to be added to the receiver view hierarchy and to be layout with "autolayout".
    /// - parameter autolayout: Closure typically used to define constraint for the receiving view.
    public func addSubview(_ view: LayoutView, autolayout: (_ view: LayoutView)->()) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        autolayout(view)
    }
}
