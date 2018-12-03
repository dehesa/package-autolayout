#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

/// Represents the left hand side of a layout constraint operation.
public struct LayoutExpression<A> where A:LayoutAnchor {
    internal let anchor: A
    internal let multiplier: CGFloat?
    internal var constant: A.Constant?
    internal var priority: LayoutPriority
    
    internal init(anchor: A, multiplier: CGFloat? = nil, constant: A.Constant? = nil, priority: LayoutPriority = .required) {
        self.anchor = anchor
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
    }
}

// MARK: - Anchors

public func * <M,A>(lhs: M, rhs: A) -> LayoutExpression<A> where A:LayoutAnchor, M:BinaryFloatingPoint {
    return .init(anchor: rhs, multiplier: CGFloat(lhs))
}

public func * <A,M>(lhs: A, rhs: M) -> LayoutExpression<A> where A:LayoutAnchor, M:BinaryFloatingPoint {
    return .init(anchor: lhs, multiplier: CGFloat(rhs))
}

public func / <A,M>(lhs: A, rhs: M) -> LayoutExpression<A> where A:LayoutAnchor, M:BinaryFloatingPoint {
    return .init(anchor: lhs, multiplier: CGFloat(1) / CGFloat(rhs))
}

public func + <A>(lhs: A, rhs: A.Constant) -> LayoutExpression<A> where A:LayoutAnchor {
    return .init(anchor: lhs, constant: rhs)
}

public func - <A>(lhs: A, rhs: A.Constant) -> LayoutExpression<A> where A:LayoutAnchor {
    return .init(anchor: lhs, constant: -rhs)
}

// MARK: - LayoutExpressions & Constants

internal func += <A>(lhs: inout LayoutExpression<A>, rhs: A.Constant) where A:LayoutAnchor {
    if let constant = lhs.constant {
        lhs.constant = constant + rhs
    } else {
        lhs.constant = rhs
    }
}

public func + <A>(lhs: LayoutExpression<A>, rhs: A.Constant) -> LayoutExpression<A> where A:LayoutAnchor {
    var result = lhs
    result += rhs
    return result
}

internal func -= <A>(lhs: inout LayoutExpression<A>, rhs: A.Constant) where A:LayoutAnchor {
    if let constant = lhs.constant {
        lhs.constant = constant - rhs
    } else {
        lhs.constant = -rhs
    }
}

public func - <A>(lhs: LayoutExpression<A>, rhs: A.Constant) -> LayoutExpression<A> where A:LayoutAnchor {
    var result = lhs
    result -= rhs
    return result
}

// MARK: - LayoutExpressions & Priority

public func ~ <A>(lhs: A, rhs: LayoutPriority) -> LayoutExpression<A> {
    return .init(anchor: lhs, priority: rhs)
}

public func ~ <A>(lhs: LayoutExpression<A>, rhs: LayoutPriority) -> LayoutExpression<A> {
    var result = lhs
    result.priority = rhs
    return result
}
