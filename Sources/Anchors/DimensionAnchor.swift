#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

public func * <M>(lhs: M, rhs: NSLayoutDimension) -> Expression
    where M:BinaryFloatingPoint {
    return .init(anchor: rhs, multiplier: CGFloat(lhs))
}

public func * <M>(lhs: NSLayoutDimension, rhs: M) -> Expression
    where M:BinaryFloatingPoint {
    return .init(anchor: lhs, multiplier: CGFloat(rhs))
}

// MARK: -

public func / <M>(lhs: NSLayoutDimension, rhs: M) -> Expression
    where M:BinaryFloatingPoint {
    return .init(anchor: lhs, multiplier: CGFloat(1) / CGFloat(rhs))
}

// MARK: -

public func + <C>(lhs: NSLayoutDimension, rhs: C) -> Expression
    where C:BinaryFloatingPoint {
    return .init(anchor: lhs, constant: CGFloat(rhs))
}

public func + <C>(lhs: Expression, rhs: C) -> Expression
    where C:BinaryFloatingPoint {
    var result = lhs
    result.constant += CGFloat(rhs)
    return result
}

// MARK: -

public func - <C>(lhs: NSLayoutDimension, rhs: C) -> Expression
    where C:BinaryFloatingPoint {
    return .init(anchor: lhs, constant: CGFloat(-rhs))
}

public func - <C>(lhs: Expression, rhs: C) -> Expression
    where C:BinaryFloatingPoint {
        var result = lhs
        result.constant -= CGFloat(rhs)
        return result
}

// MARK: -

//public func | (lhs: Expression, rhs: Activity) -> Expression {
//    var result = lhs
//    result.activate(rhs)
//    return result
//}

// MARK: -

public func ~ (lhs: NSLayoutDimension, rhs: Priority) -> Expression {
    return .init(anchor: lhs, priority: rhs)
}

public func ~ (lhs: Expression, rhs: Priority) -> Expression {
    var result = lhs
    result.priority = rhs
    return result
}

// MARK: -

@discardableResult
public func == <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint
    where C:BinaryFloatingPoint {
    return lhs.constraint(equalToConstant: CGFloat(rhs))
}

@discardableResult
public func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs)
}

@discardableResult
public func == (lhs: NSLayoutDimension, rhs: Expression) -> NSLayoutConstraint {
    return rhs.isEqual(to: lhs)
}

// MARK: -

@discardableResult
public func >= <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint
    where C:BinaryFloatingPoint {
    return lhs.constraint(greaterThanOrEqualToConstant: CGFloat(rhs))
}

@discardableResult
public func >= (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs)
}

@discardableResult
public func >= (lhs: NSLayoutDimension, rhs: Expression) -> NSLayoutConstraint {
    return rhs.isLess(than: lhs)
}

// MARK: -

@discardableResult
public func <= <C>(lhs: NSLayoutDimension, rhs: C) -> NSLayoutConstraint
    where C:BinaryFloatingPoint {
    return lhs.constraint(lessThanOrEqualToConstant: CGFloat(rhs))
}

@discardableResult
public func <= (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs)
}

@discardableResult
public func <= (lhs: NSLayoutDimension, rhs: Expression) -> NSLayoutConstraint {
    return rhs.isGreater(than: lhs)
}
