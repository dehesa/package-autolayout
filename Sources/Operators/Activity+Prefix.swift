#if canImport(AppKit)
public import AppKit
#elseif canImport(UIKit)
public import UIKit
#else
#error("OS not supported")
#endif

prefix operator ↑
prefix operator ↓

/// Postfix operation enabling/activating the constraint affected by the operator.
/// - parameter lhs: The constraint to activate.
@discardableResult @inlinable public prefix func ↑ (lhs: NSLayoutConstraint) -> NSLayoutConstraint  {
  lhs.isActive = true
  return lhs
}

/// Postfix operation enabling/activating the constraint group affected by the operator.
/// - parameter lhs: The constraint to activate.
@discardableResult @inlinable public prefix func ↑ <C>(lhs: C) -> C where C:LayoutConstraintGroup {
  lhs.forEach { $0.isActive = true }
  return lhs
}

/// Postfix operation disabling the constraint affected by the operator.
/// - parameter lhs: The constraint to disable.
@discardableResult @inlinable public prefix func ↓ (lhs: NSLayoutConstraint) -> NSLayoutConstraint  {
  lhs.isActive = false
  return lhs
}

/// Postfix operation disabling the constraint group affected by the operator.
/// - paramter lhs: The constraint/s to disable.
@discardableResult @inlinable public prefix func ↓ <C>(lhs: C) -> C where C:LayoutConstraintGroup {
  lhs.forEach { $0.isActive = false }
  return lhs
}
