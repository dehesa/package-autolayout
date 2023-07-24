#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#else
#error("OS not supported")
#endif

// MARK: Equality

@discardableResult @inlinable public func == <A>(lhs: A, rhs: A.Constant) -> A.Constraint where A:LayoutAnchorConstant {
  lhs.constraint(equalToConstant: rhs)
}

@discardableResult @inlinable public func == <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
  lhs.constraint(equalTo: rhs, multiplier: .none, constant: .init())
}

@discardableResult @inlinable public func == <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
  lhs.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
}

// MARK: - Greater than or Equal

@discardableResult @inlinable public func >= <A>(lhs: A, rhs: A.Constant) -> A.Constraint where A:LayoutAnchorConstant {
  lhs.constraint(greaterThanOrEqualToConstant: rhs)
}

@discardableResult @inlinable public func >= <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
  lhs.constraint(greaterThanOrEqualTo: rhs, multiplier: .none, constant: .init())
}

@discardableResult @inlinable public func >= <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
  lhs.constraint(greaterThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
}

// MARK: - Less than or Equal

@discardableResult @inlinable public func <= <A>(lhs: A, rhs: A.Constant) -> A.Constraint where A:LayoutAnchorConstant {
  lhs.constraint(lessThanOrEqualToConstant: rhs)
}

@discardableResult @inlinable public func <= <A>(lhs: A, rhs: A) -> A.Constraint where A:LayoutAnchor {
  lhs.constraint(lessThanOrEqualTo: rhs, multiplier: nil, constant: .init())
}

@discardableResult @inlinable public func <= <A>(lhs: A, rhs: LayoutExpression<A>) -> A.Constraint where A:LayoutAnchor {
  lhs.constraint(lessThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier, constant: rhs.constant)
}
