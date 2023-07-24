#if canImport(AppKit)
import AppKit
public typealias LayoutPriority = NSLayoutConstraint.Priority
#elseif canImport(UIKit)
import UIKit
public typealias LayoutPriority = UILayoutPriority
#else
#error("OS not supported")
#endif

extension LayoutPriority: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
  /// The priority level with which a button resists compressing its content.
  @_transparent public static var high: LayoutPriority { .defaultHigh }
  /// The priority level at which a button hugs its contents horizontally.
  @_transparent public static var low: LayoutPriority { .defaultLow }

  public init(integerLiteral value: IntegerLiteralType) {
    self.init(Float(value))
  }

  public init(floatLiteral value: FloatLiteralType) {
    self.init(Float(value))
  }

  /// Creates a layout priority with a numeric value (from 1 to 1000).
  @inlinable public init<I>(_ value: I) where I:BinaryInteger {
    self.init(Float(value))
  }

  /// Creates a layout priority with a numeric value (from 1 to 1000).
  @inlinable public init<F>(_ value: F) where F:BinaryFloatingPoint {
    self.init(Float(value))
  }
}

/// Operation adding two priorities together and returning it as a new layout priority.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority addition.
@discardableResult @inlinable public func + <C>(lhs: LayoutPriority, rhs: C) -> LayoutPriority where C:BinaryInteger {
  LayoutPriority(lhs.rawValue + Float(rhs))
}

/// Operation adding two priorities together and returning it as a new layout priority.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority addition.
@discardableResult @inlinable public func + <C>(lhs: LayoutPriority, rhs: C) -> LayoutPriority where C:BinaryFloatingPoint {
  LayoutPriority(lhs.rawValue + Float(rhs))
}

/// Operation subtracting two priorities together and returning it as a new layout priority.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority subtraction.
@discardableResult @inlinable public func - <C>(lhs: LayoutPriority, rhs: C) -> LayoutPriority where C:BinaryInteger {
  LayoutPriority(lhs.rawValue - Float(rhs))
}

/// Operation subtracting two priorities together and returning it as a new layout priority.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority subtraction.
@discardableResult @inlinable public func - <C>(lhs: LayoutPriority, rhs: C) -> LayoutPriority where C:BinaryFloatingPoint {
  LayoutPriority(lhs.rawValue - Float(rhs))
}

infix operator ~ : LogicalConjunctionPrecedence

/// Operation setting the priority of a receiving layout constraint.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority subtraction.
@discardableResult @inlinable public func ~ (lhs: NSLayoutConstraint, rhs: LayoutPriority) -> NSLayoutConstraint {
  lhs.priority = rhs
  return lhs
}

/// Operation setting the priority of a receiving layout constraint.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority subtraction.
@discardableResult @inlinable public func ~ <C>(lhs: C, rhs: C.Priority) -> C where C:LayoutConstraintGroup {
  lhs.priority = rhs
  return lhs
}

/// Operation setting the priority of a receiving layout constraint.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority subtraction.
@discardableResult @inlinable public func ~ <C>(lhs: C, rhs: LayoutPriority) -> C where C:LayoutConstraintGroup {
  lhs.forEach { $0.priority = rhs }
  return lhs
}
