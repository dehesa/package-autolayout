#if canImport(AppKit)
public import AppKit
public typealias LayoutView = NSView
#elseif canImport(UIKit)
public import UIKit
public typealias LayoutView = UIView
#else
#error("OS not supported")
#endif

public extension LayoutView {
  /// Disables the automatic conversion of autoresing mask into constraints.
  /// - note: Do this before a view is added to the view hierarchy.
  @_transparent func disableAutoresizingMask() {
    self.translatesAutoresizingMaskIntoConstraints = false
  }

  /// Prepares the given parameter view to work in autolayout, adds it to the receiver view hierarchy, and executes (immediately) the given closure.
  /// - parameter view: The view to be added to the receiver view hierarchy.
  /// - parameter constraintGenerator: Closure typically used to define constraint for the receiving view.
  @_transparent func addSubview<V>(_ view: V, _ constraintGenerator: (_ view: V) -> Void) where V: LayoutView {
    view.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(view)
    constraintGenerator(view)
  }

  /// Prepares the given parameter view to work in autolayout, adds it to the receiver view hierarchy, and executes (immediately) the given closure.
  /// - parameter view: The view to be added to the receiver view hierarchy.
  /// - parameter constraintGenerator: Closure typically used to define constraint for the receiving view.
  /// - parameter superview: The view receiving the `addSubview(_:)` method call.
  @inlinable func addSubview<V>(_ view: V, _ constraintGenerator: (_ superview: Self, _ view: V) -> Void) where V: LayoutView {
    view.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(view)
    constraintGenerator(unsafeDowncast(self, to: Self.self), view)
  }
}
