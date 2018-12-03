#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

public func * <M,A>(lhs: M, rhs: A) -> Expression<A> where A:Anchor, M:BinaryFloatingPoint {
    return .init(anchor: rhs, multiplier: CGFloat(lhs))
}

public func * <A,M>(lhs: A, rhs: M) -> Expression<A> where A:Anchor, M:BinaryFloatingPoint {
    return .init(anchor: lhs, multiplier: CGFloat(rhs))
}

// MARK: -

public func / <A,M>(lhs: A, rhs: M) -> Expression<A> where A:Anchor, M:BinaryFloatingPoint {
    return .init(anchor: lhs, multiplier: CGFloat(1) / CGFloat(rhs))
}

// MARK: -

public func + <A>(lhs: A, rhs: A.Constant) -> Expression<A> where A:Anchor {
    return .init(anchor: lhs, constant: rhs)
}

public func + <A>(lhs: Expression<A>, rhs: A.Constant) -> Expression<A>
    where A:Anchor {
    var result = lhs
    result.constant += rhs
    return result
}

// MARK: -

public func - <A>(lhs: A, rhs: A.Constant) -> Expression<A> where A:Anchor {
    return .init(anchor: lhs, constant: -rhs)
}

public func - <A>(lhs: Expression<A>, rhs: A.Constant) -> Expression<A> where A:Anchor {
    var result = lhs
    result.constant -= rhs
    return result
}

// MARK: -

public func ~ <A>(lhs: A, rhs: Priority) -> Expression<A> {
    return .init(anchor: lhs, priority: rhs)
}

public func ~ <A>(lhs: Expression<A>, rhs: Priority) -> Expression<A> {
    var result = lhs
    result.priority = rhs
    return result
}

// MARK: -

@discardableResult
public func == <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint where C:BinaryFloatingPoint {
    return lhs.constraint(equalToConstant: CGFloat(rhs))
}

@discardableResult
public func == <A>(lhs: A, rhs: A) -> NSLayoutConstraint where A:SingleAnchor {
    return lhs.constraint(equalTo: rhs, multiplier: 1, constant: .init(), priority: .required)
}

@discardableResult
public func == <A>(lhs: A, rhs: Expression<A>) -> NSLayoutConstraint where A:SingleAnchor {
    return lhs.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant, priority: rhs.priority)
}

// MARK: -

@discardableResult
public func >= <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint where C:BinaryFloatingPoint {
    return lhs.constraint(greaterThanOrEqualToConstant: CGFloat(rhs))
}

@discardableResult
public func >= <A>(lhs: A, rhs: A) -> NSLayoutConstraint where A:SingleAnchor {
    return lhs.constraint(greaterThan: rhs, multiplier: 1, constant: .init(), priority: .required)
}

@discardableResult
public func >= <A>(lhs: A, rhs: Expression<A>) -> NSLayoutConstraint where A:SingleAnchor {
    return lhs.constraint(greaterThan: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant, priority: rhs.priority)
}

// MARK: -

@discardableResult
public func <= <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint where C:BinaryFloatingPoint {
    return lhs.constraint(lessThanOrEqualToConstant: CGFloat(rhs))
}

@discardableResult
public func <= <A>(lhs: A, rhs: A) -> NSLayoutConstraint where A:SingleAnchor {
    return lhs.constraint(lessThan: rhs, multiplier: 1, constant: .init(), priority: .required)
}

@discardableResult
public func <= <A>(lhs: A, rhs: Expression<A>) -> NSLayoutConstraint where A:SingleAnchor {
    return lhs.constraint(lessThan: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant, priority: rhs.priority)
}
