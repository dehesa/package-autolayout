#if canImport(AppKit)
public import AppKit
#elseif canImport(UIKit)
public import UIKit
#else
#error("OS not supported")
#endif

precedencegroup LayoutActivationPrecedence {
  lowerThan: ComparisonPrecedence
  higherThan: AssignmentPrecedence
  associativity: left
}

infix operator ↑ : LayoutActivationPrecedence
infix operator ↓ : LogicalDisjunctionPrecedence

/// Infix operation activing and identifying the constraint on the operation's left handside.
/// - parameter lhs: The constraint to be actuated upon.
/// - parameter rhs: The identifier to be assigned to the constraint.
/// - returns: The modified `lhs`.
@discardableResult @inlinable public func ↑ (lhs: NSLayoutConstraint, rhs: String?) -> NSLayoutConstraint {
  lhs.identifier = rhs
  lhs.isActive = true
  return lhs
}

/// Infix operation activing and identifying the constraint group on the operation's left handside.
/// - parameter lhs: The constraint group to be actuated upon.
/// - parameter rhs: The identifier to be assigned to all constraints in the constraint group.
/// - returns: The modified `lhs`.
@discardableResult @inlinable public func ↑ <C>(lhs: C, rhs: String?) -> C where C:LayoutConstraintGroup {
  if let rhs {
    lhs.identify(root: rhs, suffixes: C.defaultSuffixes)
    lhs.forEach { $0.isActive = true }
  } else {
    lhs.forEach {
      $0.identifier = .none
      $0.isActive = true
    }
  }
  return lhs
}

/// Infix operation activing and identifying the constraint group on the operation's left handside.
/// - parameter lhs: The constraint group to be actuated upon.
/// - parameter rhs: The identifiers to be assigned each constraint in the constraint group.
/// - returns: The modified `lhs`.
@discardableResult @inlinable public func ↑ <C>(lhs: C, rhs: C.Identifier) -> C where C:LayoutConstraintGroup {
  lhs.identifier = rhs
  lhs.forEach { $0.isActive = true }
  return lhs
}

/// Infix operation activing and identifying the constraint group on the operation's left handside.
/// - parameter lhs: The constraint group to be actuated upon.
/// - parameter rhs: The root identifier to be preppended and the identifiers to be suffixed to each constraint.
/// - returns: The modified `lhs`.
@discardableResult @inlinable public func ↑ <C>(lhs: C, rhs: (root: String, suffixes: C.Identifier)) -> C where C:LayoutConstraintGroup {
  lhs.identify(root: rhs.root, suffixes: rhs.suffixes)
  lhs.forEach { $0.isActive = true }
  return lhs
}

/// Infix operation disabling and identifying the constraint on the operation's left handside.
/// - parameter lhs: The constraint to be actuated upon.
/// - parameter rhs: The identifier to be assigned to the constraint.
/// - returns: The modified `lhs`.
@discardableResult @inlinable public func ↓ (lhs: NSLayoutConstraint, rhs: String?) -> NSLayoutConstraint {
  lhs.identifier = rhs
  lhs.isActive = false
  return lhs
}

/// Infix operation disabling and identifying the constraint group on the operation's left handside.
/// - parameter lhs: The constraint group to be actuated upon.
/// - parameter rhs: The identifier to be assigned to all constraints in the constraint group.
/// - returns: The modified `lhs`.
@discardableResult @inlinable public func ↓ <C>(lhs: C, rhs: String?) -> C where C:LayoutConstraintGroup {
  if let rhs {
    lhs.identify(root: rhs, suffixes: C.defaultSuffixes)
    lhs.forEach { $0.isActive = false }
  } else {
    lhs.forEach {
      $0.identifier = .none
      $0.isActive = false
    }
  }
  return lhs
}

/// Infix operation disabling and identifying the constraint group on the operation's left handside.
/// - parameter lhs: The constraint group to be actuated upon.
/// - parameter rhs: The identifiers to be assigned each constraint in the constraint group.
/// - returns: The modified `lhs`.
@discardableResult @inlinable public func ↓ <C>(lhs: C, rhs: C.Identifier) -> C where C:LayoutConstraintGroup {
  lhs.identifier = rhs
  lhs.forEach { $0.isActive = false }
  return lhs
}

/// Infix operation disabling and identifying the constraint group on the operation's left handside.
/// - parameter lhs: The constraint group to be actuated upon.
/// - parameter rhs: The root identifier to be preppended and the identifiers to be suffixed to each constraint.
/// - returns: The modified `lhs`.
@discardableResult @inlinable public func ↓ <C>(lhs: C, rhs: (root: String, suffixes: C.Identifier)) -> C where C:LayoutConstraintGroup {
  lhs.identify(root: rhs.root, suffixes: rhs.suffixes)
  lhs.forEach { $0.isActive = false }
  return lhs
}
