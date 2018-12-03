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

@discardableResult
public postfix func ↑ <S>(lhs: S) -> S where S:Sequence, S.Element == NSLayoutConstraint {
    lhs.forEach { $0.isActive = true }
    return lhs
}

postfix operator ↓

@discardableResult
public postfix func ↓ (lhs: NSLayoutConstraint) -> NSLayoutConstraint {
    lhs.isActive = false
    return lhs
}

@discardableResult
public postfix func ↓ <S>(lhs: S) -> S where S:Sequence, S.Element == NSLayoutConstraint {
    lhs.forEach { $0.isActive = false }
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

@discardableResult
public func ↑ <S,C>(lhs: S, rhs: (String, C)) -> S where S:Sequence, S.Element == NSLayoutConstraint, C:Sequence, C.Element == String {
    for (constraint, suffix) in zip(lhs, rhs.1) {
        constraint.isActive = true
        constraint.identifier = rhs.0.appending(suffix)
    }
    return lhs
}

infix operator ↓ : LogicalConjunctionPrecedence

@discardableResult
public func ↓ (lhs: NSLayoutConstraint, rhs: String) -> NSLayoutConstraint {
    lhs.isActive = false
    lhs.identifier = rhs
    return lhs
}

@discardableResult
public func ↓ <S,C>(lhs: S, rhs: (String, C)) -> S where S:Sequence, S.Element == NSLayoutConstraint, C:Sequence, C.Element == String {
    for (constraint, suffix) in zip(lhs, rhs.1) {
        constraint.isActive = false
        constraint.identifier = rhs.0.appending(suffix)
    }
    return lhs
}
