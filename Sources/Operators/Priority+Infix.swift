#if canImport(AppKit)
public import AppKit
#elseif canImport(UIKit)
public import UIKit
#endif

precedencegroup LayoutPriorityPrecendence {
  lowerThan: ComparisonPrecedence
  higherThan: LayoutActivationPrecedence
  associativity: left
}

infix operator ~ : LayoutPriorityPrecendence

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
