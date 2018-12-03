#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

// MARK: Equality

@discardableResult
public func == <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint where C:BinaryFloatingPoint {
    return lhs.constraint(equalToConstant: CGFloat(rhs))
}

@discardableResult
public func == <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(equalTo: rhs, .required, multiplier: nil, constant: nil)
}

@discardableResult
public func == <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(equalTo: rhs.anchor, .required, multiplier: rhs.multiplier, constant: rhs.constant)
}

// MARK: - Greater than or Equal

@discardableResult
public func >= <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint where C:BinaryFloatingPoint {
    return lhs.constraint(greaterThanOrEqualToConstant: CGFloat(rhs))
}

@discardableResult
public func >= <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(greaterThanOrEqualTo: rhs, .required, multiplier: nil, constant: nil)
}

@discardableResult
public func >= <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(greaterThanOrEqualTo: rhs.anchor, .required, multiplier: rhs.multiplier, constant: rhs.constant)
}

// MARK: - Less than or Equal

@discardableResult
public func <= <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint where C:BinaryFloatingPoint {
    return lhs.constraint(lessThanOrEqualToConstant: CGFloat(rhs))
}

@discardableResult
public func <= <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(lessThanOrEqualTo: rhs, .required, multiplier: nil, constant: nil)
}

@discardableResult
public func <= <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(lessThanOrEqualTo: rhs.anchor, .required, multiplier: rhs.multiplier, constant: rhs.constant)
}
