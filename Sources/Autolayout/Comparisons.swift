#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#else
#error("OS not supported")
#endif

// MARK: Equality

@discardableResult
public func == <A>(lhs: A, rhs: A.Constant) -> A.Constraint where A:LayoutAnchorConstant {
    return lhs.constraint(equalToConstant: rhs)
}

@discardableResult
public func == <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(equalTo: rhs, multiplier: .none, constant: .init())
}

@discardableResult
public func == <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
}

// MARK: - Greater than or Equal

@discardableResult
public func >= <A>(lhs: A, rhs: A.Constant) -> A.Constraint where A:LayoutAnchorConstant {
    return lhs.constraint(greaterThanOrEqualToConstant: rhs)
}

@discardableResult
public func >= <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(greaterThanOrEqualTo: rhs, multiplier: .none, constant: .init())
}

@discardableResult
public func >= <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(greaterThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
}

// MARK: - Less than or Equal

@discardableResult
public func <= <A>(lhs: A, rhs: A.Constant) -> A.Constraint where A:LayoutAnchorConstant {
    return lhs.constraint(lessThanOrEqualToConstant: rhs)
}

@discardableResult
public func <= <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(lessThanOrEqualTo: rhs, multiplier: nil, constant: .init())
}

@discardableResult
public func <= <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
    return lhs.constraint(lessThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
}
