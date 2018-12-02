#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

// MARK: - Multiplication

//@discardableResult
//func * <A,M>(lhs: A, rhs: M) -> Expression<A> where A:Anchor, M:BinaryFloatingPoint {
//    return Expression(anchor: lhs, multiplier: CGFloat(rhs), constant: 0.0)
//}
//
//@discardableResult
//func * <A,M>(lhs: M, rhs: A) -> Expression<A> where A:Anchor, M:BinaryFloatingPoint {
//    return Expression(anchor: rhs, multiplier: CGFloat(lhs), constant: 0.0)
//}
//
//@discardableResult
//func * <A,M>(lhs: Expression<A>, rhs: M) -> Expression<A> where A:Anchor, M:BinaryFloatingPoint {
//    var expr = lhs
//    expr.multiplier *= CGFloat(rhs)
//    return expr
//}
//
//@discardableResult
//func * <A,M>(lhs: M, rhs: Expression<A>) -> Expression<A> where A:Anchor, M:BinaryFloatingPoint {
//    var expr = rhs
//    expr.multiplier *= CGFloat(lhs)
//    return expr
//}

// MARK: - Division

//@discardableResult
//func / <A,M>(lhs: A, rhs: M) -> Expression<A> where A:Anchor, M:BinaryFloatingPoint {
//    return Expression(anchor: lhs, multiplier: 1.0 / CGFloat(rhs), constant: 0.0)
//}
//
//@discardableResult
//func / <A,M>(lhs: Expression<A>, rhs: M) -> Expression<A> where A:Anchor, M:BinaryFloatingPoint {
//    var expr = lhs
//    expr.multiplier /= CGFloat(rhs)
//    return expr
//}

// MARK: - Addition

//@discardableResult
//func + <A,C>(lhs: A, rhs: C) -> Expression<A> where A:Anchor, C:BinaryFloatingPoint {
//    return Expression(anchor: lhs, constant: CGFloat(rhs))
//}
//
//@discardableResult
//func + <A,C>(lhs: C, rhs: A) -> Expression<A> where A:Anchor, C:BinaryFloatingPoint {
//    return Expression(anchor: rhs, constant: CGFloat(lhs))
//}
//
//@discardableResult
//func + <A,C>(lhs: Expression<A>, rhs: C) -> Expression<A> where A:Anchor, C:BinaryFloatingPoint {
//    var expr = lhs
//    expr.constant += CGFloat(rhs)
//    return expr
//}
//
//@discardableResult
//func + <A,C>(lhs: C, rhs: Expression<A>) -> Expression<A> where A:Anchor, C:BinaryFloatingPoint {
//    var expr = rhs
//    expr.constant += CGFloat(lhs)
//    return expr
//}
//
//@discardableResult
//func + <P>(lhs: UILayoutPriority, rhs: P) -> UILayoutPriority where P:BinaryInteger {
//    return UILayoutPriority(lhs.rawValue + Float(rhs))
//}

// MARK: - Substraction

//@discardableResult
//func - <A,C>(lhs: A, rhs: C) -> Expression<A> where A:Anchor, C:BinaryFloatingPoint {
//    return Expression(anchor: lhs, constant: -CGFloat(rhs))
//}
//
//@discardableResult
//func - <A,C>(lhs: C, rhs: A) -> Expression<A> where A:Anchor, C:BinaryFloatingPoint {
//    return Expression(anchor: rhs, constant: -CGFloat(lhs))
//}
//
//@discardableResult
//func - <A,C>(lhs: Expression<A>, rhs: C) -> Expression<A> where A:Anchor, C:BinaryFloatingPoint {
//    var expr = lhs
//    expr.constant -= CGFloat(rhs)
//    return expr
//}
//
//@discardableResult
//func - <A,C>(lhs: C, rhs: Expression<A>) -> Expression<A> where A:Anchor, C:BinaryFloatingPoint {
//    var expr = rhs
//    expr.constant -= CGFloat(lhs)
//    return expr
//}
//
//@discardableResult
//func - <P>(lhs: UILayoutPriority, rhs: P) -> UILayoutPriority where P:BinaryInteger {
//    return UILayoutPriority(lhs.rawValue - Float(rhs))
//}

// MARK: - Priority

//precedencegroup LayoutPriorityPrecedence {
//    associativity: none
//    lowerThan: AdditionPrecedence
//    higherThan: CastingPrecedence
//}
//
//infix operator ~ : LayoutPriorityPrecedence
//
//@discardableResult
//func ~ <A>(lhs: A, rhs: UILayoutPriority) -> Expression<A> where A:Anchor {
//    return Expression(anchor: lhs, constant: 0.0, priority: rhs)
//}
//
//@discardableResult
//func ~ <A>(lhs: Expression<A>, rhs: UILayoutPriority) -> Expression<A> where A:Anchor {
//    var expr = lhs
//    expr.priority = rhs
//    return expr
//}
//
//@discardableResult
//func ~ <C>(lhs: C, rhs: UILayoutPriority) -> Expression<NSLayoutDimension> where C:BinaryFloatingPoint {
//    return Expression(constant: CGFloat(lhs), priority: rhs)
//}
//
//
//@discardableResult
//func ~ (lhs: NSLayoutConstraint, rhs: UILayoutPriority) -> NSLayoutConstraint {
//    lhs.priority = rhs
//    return lhs
//}

// MARK: - Equality

//@discardableResult
//func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
//    return lhs.constraint(equalTo: rhs)
//}
//
//@discardableResult
//func == (lhs: NSLayoutXAxisAnchor, rhs: Expression<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
//    let constraint = lhs.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant)
//    constraint.priority = rhs.priority
//    return constraint.activate(rhs.activity)
//}
//
//@discardableResult
//func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
//    return lhs.constraint(equalTo: rhs)
//}
//
//@discardableResult
//func == (lhs: NSLayoutYAxisAnchor, rhs: Expression<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
//    let constraint = lhs.constraint(equalTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant)
//    constraint.priority = rhs.priority
//    return constraint.activate(rhs.activity)
//}

//@discardableResult
//func == (lhs: NSLayoutDimension, rhs: Expression<NSLayoutDimension>) -> NSLayoutConstraint {
//    let constraint: NSLayoutConstraint
//
//    if let anchor = rhs.anchor {
//        constraint = lhs.constraint(equalTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant)
//    } else {
//        constraint = lhs.constraint(equalToConstant: rhs.constant)
//    }
//
//    constraint.priority = rhs.priority
//    return constraint.activate(rhs.activity)
//}

// MARK: - Inequality

//@discardableResult
//func <= (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
//    return lhs.constraint(lessThanOrEqualTo: rhs)
//}
//
//@discardableResult
//func <= (lhs: NSLayoutXAxisAnchor, rhs: Expression<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
//    let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant)
//    constraint.priority = rhs.priority
//    return constraint.activate(rhs.activity)
//}
//
//@discardableResult
//func <= (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
//    return lhs.constraint(lessThanOrEqualTo: rhs)
//}
//
//@discardableResult
//func <= (lhs: NSLayoutYAxisAnchor, rhs: Expression<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
//    let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant)
//    constraint.priority = rhs.priority
//    return constraint.activate(rhs.activity)
//}
//
//@discardableResult
//func <= (lhs: NSLayoutDimension, rhs: Expression<NSLayoutDimension>) -> NSLayoutConstraint {
//    let constraint: NSLayoutConstraint
//
//    if let anchor = rhs.anchor {
//        constraint = lhs.constraint(lessThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant)
//    }
//    else {
//        constraint = lhs.constraint(lessThanOrEqualToConstant: rhs.constant)
//    }
//
//    constraint.priority = rhs.priority
//    return constraint.activate(rhs.activity)
//}
//
//@discardableResult
//func >= (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
//    return lhs.constraint(greaterThanOrEqualTo: rhs)
//}
//
//@discardableResult
//func >= (lhs: NSLayoutXAxisAnchor, rhs: Expression<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
//    let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant)
//    constraint.priority = rhs.priority
//    return constraint.activate(rhs.activity)
//}
//
//@discardableResult
//func >= (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
//    return lhs.constraint(greaterThanOrEqualTo: rhs)
//}
//
//@discardableResult
//func >= (lhs: NSLayoutYAxisAnchor, rhs: Expression<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
//    let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor!, multiplier: rhs.multiplier, constant: rhs.constant)
//    constraint.priority = rhs.priority
//    return constraint.activate(rhs.activity)
//}
//
//@discardableResult
//func >= (lhs: NSLayoutDimension, rhs: Expression<NSLayoutDimension>) -> NSLayoutConstraint {
//    let constraint: NSLayoutConstraint
//
//    if let anchor = rhs.anchor {
//        constraint = lhs.constraint(greaterThanOrEqualTo: anchor, multiplier: rhs.multiplier, constant: rhs.constant)
//    }
//    else {
//        constraint = lhs.constraint(greaterThanOrEqualToConstant: rhs.constant)
//    }
//
//    constraint.priority = rhs.priority
//    return constraint.activate(rhs.activity)
//}

// MARK: - Activity & Identification

//infix operator | : DefaultPrecedence
//
//@discardableResult
//func | <A>(lhs: A, rhs: Activity) -> Expression<A> where A:Anchor {
//    return Expression(anchor: lhs, constant: 0.0, activity: rhs)
//}
//
//@discardableResult
//func | <A>(lhs: Expression<A>, rhs: Activity) -> Expression<A> where A:Anchor {
//    return lhs.setting(activity: rhs)
//}
//
//@discardableResult
//func | (lhs: NSLayoutConstraint, rhs: Activity) -> NSLayoutConstraint {
//    return lhs.activate(rhs)
//}
//
//@discardableResult
//func | (lhs: NSLayoutConstraint, rhs: String?) -> NSLayoutConstraint {
//    lhs.identifier = rhs
//    return lhs
//}
//
//@discardableResult
//func | (lhs: NSLayoutConstraint, rhs: (Activity, String?)) -> NSLayoutConstraint {
//    lhs.identifier = rhs.1
//    return lhs.activate(rhs.0)
//}
