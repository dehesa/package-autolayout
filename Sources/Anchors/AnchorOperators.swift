#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
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
    return lhs.constraint(equalTo: rhs, .required, multiplier: nil, constant: .init())
}

@discardableResult
public func == <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(equalTo: rhs.anchor, rhs.priority, multiplier: rhs.multiplier, constant: rhs.constant)
}

// MARK: - Greater than or Equal

@discardableResult
public func >= <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint where C:BinaryFloatingPoint {
    return lhs.constraint(greaterThanOrEqualToConstant: CGFloat(rhs))
}

@discardableResult
public func >= <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(greaterThanOrEqualTo: rhs, .required, multiplier: nil, constant: .init())
}

@discardableResult
public func >= <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(greaterThanOrEqualTo: rhs.anchor, rhs.priority, multiplier: rhs.multiplier, constant: rhs.constant)
}

// MARK: - Less than or Equal

@discardableResult
public func <= <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint where C:BinaryFloatingPoint {
    return lhs.constraint(lessThanOrEqualToConstant: CGFloat(rhs))
}

@discardableResult
public func <= <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(lessThanOrEqualTo: rhs, .required, multiplier: nil, constant: .init())
}

@discardableResult
public func <= <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(lessThanOrEqualTo: rhs.anchor, rhs.priority, multiplier: rhs.multiplier, constant: rhs.constant)
}
