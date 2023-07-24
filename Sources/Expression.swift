#if canImport(QuartzCore)
import QuartzCore
#else
#error("CGFloat types are not supported")
#endif

/// Represents the rigth handside of a layout constraint operation.
///
/// On a expression such as
/// ```swift
/// anchorA >= 2 * anchorB - 5.2
/// ```
/// a `LayoutExpression` references the
/// ```swift
/// 2 * anchorB - 5.2
/// ```
/// part and a further priority setting (e.g. `.required`).
public struct LayoutExpression<A> where A:LayoutAnchor {
  /// The anchor involved on the operation's right handside.
  @usableFromInline let anchor: A
  /// The constant by which the `anchor` will be mltiplied by.
  @usableFromInline let multiplier: CGFloat?
  /// The constant to be added to the anchor.
  internal(set) public var constant: A.Constant

  /// Designated initializer passing all propreties of the layot expression right handside.
  @usableFromInline init(anchor: A, multiplier: CGFloat? = nil, constant: A.Constant = .init()) {
    self.anchor = anchor
    self.multiplier = multiplier
    self.constant = constant
  }
}

// MARK: - Anchor & Value

/// Operation setting a layout multiplier (left handside) and the layout anchor (right handside).
/// - parameter lhs: The multiplier for the layout expression.
/// - parameter rhs: The anchor for the layout expression.
/// - return: A layout expression with the default values and the given anchor and multiplier.
@inlinable public func * <M,A>(lhs: M, rhs: A) -> LayoutExpression<A> where A:LayoutAnchor, M:BinaryFloatingPoint {
  LayoutExpression(anchor: rhs, multiplier: CGFloat(lhs))
}

/// Operation setting a layout multiplier (right handside) and the layout anchor (left handside).
/// - parameter lhs: The anchor for the layout expression.
/// - parameter rhs: The multiplier for the layout expression.
/// - return: A layout expression with the default values and the given anchor and multiplier.
@inlinable public func * <A,M>(lhs: A, rhs: M) -> LayoutExpression<A> where A:LayoutAnchor, M:BinaryFloatingPoint {
  LayoutExpression(anchor: lhs, multiplier: CGFloat(rhs))
}

/// Operation setting a layout multiplier (right handside) and the layout anchor (left handside).
/// - parameter lhs: The anchor for the layout expression.
/// - parameter rhs: The multiplier for the layout expression.
/// - return: A layout expression with the default values and the given anchor and multiplier.
@inlinable public func / <A,M>(lhs: A, rhs: M) -> LayoutExpression<A> where A:LayoutAnchor, M:BinaryFloatingPoint {
  LayoutExpression(anchor: lhs, multiplier: CGFloat(1) / CGFloat(rhs))
}

/// Operation setting a layout constant (right handside) and the layout anchor (left handside).
/// - parameter lsh: The anchor for the layout expression.
/// - parameter rhs: The constant for the layout expression.
/// - return: A layout expression with the default values and the given anchor and constant.
@inlinable public func + <A>(lhs: A, rhs: A.Constant) -> LayoutExpression<A> where A:LayoutAnchor {
  LayoutExpression(anchor: lhs, constant: rhs)
}

/// Operation setting a layout constant (right handside) and the layout anchor (left handside).
/// - parameter lsh: The anchor for the layout expression.
/// - parameter rhs: The constant for the layout expression.
/// - return: A layout expression with the default values and the given anchor and constant.
@inlinable public func - <A>(lhs: A, rhs: A.Constant) -> LayoutExpression<A> where A:LayoutAnchor {
  LayoutExpression(anchor: lhs, constant: -rhs)
}

// MARK: - Expression & Constants

/// Operation adding the passed constant to the receiving layout expression.
/// - parameter lhs: The affected layout expression.
/// - parameter rhs: The constant to be added to the receiving expression.
@usableFromInline func += <A>(lhs: inout LayoutExpression<A>, rhs: A.Constant) where A:LayoutAnchor {
  lhs.constant += rhs
}

/// Operation subtracting the passed constant to the receiving layout expression.
/// - parameter lhs: The affected layout expression.
/// - parameter rhs: The constant to be subtracted to the receiving expression.
@usableFromInline func -= <A>(lhs: inout LayoutExpression<A>, rhs: A.Constant) where A:LayoutAnchor {
  lhs.constant -= rhs
}

/// Operation adding a constant to a layout, returning the result (as a different instance).
/// - parameter lhs: The receiving layout expression.
/// - parameter rhs: The constant to be added to the expression.
/// - returns: A duplication of `lhs` with the constant addition.
@inlinable public func + <A>(lhs: LayoutExpression<A>, rhs: A.Constant) -> LayoutExpression<A> where A:LayoutAnchor {
  var result = lhs
  result += rhs
  return result
}

/// Operation subtracting a constant to a layout, returning the result (as a different instance).
/// - parameter lhs: The receiving layout expression.
/// - parameter rhs: The constant to be subtracted to the expression.
/// - returns: A duplication of `lhs` with the constant subtraction.
@inlinable public func - <A>(lhs: LayoutExpression<A>, rhs: A.Constant) -> LayoutExpression<A> where A:LayoutAnchor {
  var result = lhs
  result -= rhs
  return result
}
