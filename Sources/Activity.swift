#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

// MARK: - Postfix

postfix operator ↑

@discardableResult
public postfix func ↑ (lhs: NSLayoutConstraint) -> NSLayoutConstraint {
    lhs.isActive = true
    return lhs
}

postfix operator ↓

@discardableResult
public postfix func ↓ (lhs: NSLayoutConstraint) -> NSLayoutConstraint {
    lhs.isActive = false
    return lhs
}

// MARK: - Infix

infix operator ↑ : LogicalConjunctionPrecedence

@discardableResult
public func ↑ (lhs: NSLayoutConstraint, rhs: String) -> NSLayoutConstraint {
    lhs.isActive = true
    lhs.identifier = rhs
    return lhs
}

infix operator ↓ : LogicalConjunctionPrecedence

@discardableResult
public func ↓ (lhs: NSLayoutConstraint, rhs: String) -> NSLayoutConstraint {
    lhs.isActive = false
    lhs.identifier = rhs
    return lhs
}
