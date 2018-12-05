#if canImport(QuartzCore)
import QuartzCore
#else
#error("CGFloat types are not supported")
#endif

/// Packages a layout constant and expression in a single instance.
public protocol LayoutExpression {
    associatedtype Anchor: LayoutAnchor
    /// The constant to be added to the anchor.
    var constant: Anchor.Constant { get }
    /// The priority of the generated constraint.
    var priority: LayoutPriority { get }
}

/// Represents the right handside of a dimension layout constraint operation.
public struct LayoutConstantExpression<A>: LayoutExpression where A:LayoutAnchor {
    public typealias Anchor = A
    internal(set) public var constant: A.Constant
    internal(set) public var priority: LayoutPriority
    /// Designated initializer passing all properties of the layout expression right handside.
    internal init(constant: A.Constant, priority: LayoutPriority = .required) {
        self.constant = constant
        self.priority = priority
    }
}

/// Represents the rigth handside of a layout constraint operation.
///
/// On a expression such as
/// ```
/// anchorA >= 2 * anchorB - 5.2
/// ```
/// a `LayoutExpression` references the
/// ```
/// 2 * anchorB - 5.2
/// ```
/// part and a further priority setting (e.g. `.required`).
public struct LayoutAnchoredExpression<A>: LayoutExpression where A:LayoutAnchor {
    public typealias Anchor = A
    
    /// The constant to be added to the anchor.
    internal(set) public var constant: A.Constant
    /// The priority of the generated constraint.
    internal(set) public var priority: LayoutPriority
    /// The anchor involved on the operation's right handside.
    internal let anchor: A
    /// The constant by which the `anchor` will be mltiplied by.
    internal let multiplier: CGFloat?
    
    /// Designated initializer passing all propreties of the layot expression right handside.
    internal init(anchor: A, multiplier: CGFloat? = nil, constant: A.Constant = .init(), priority: LayoutPriority = .required) {
        self.anchor = anchor
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
    }
}

// MARK: - Anchor & Value

/// Operation setting a layout multiplier (left handside) and the layout anchor (right handside).
/// - parameter lhs: The multiplier for the layout expression.
/// - parameter rhs: The anchor for the layout expression.
/// - return: A layout expression with the default values and the given anchor and multiplier.
public func * <M,A>(lhs: M, rhs: A) -> LayoutAnchoredExpression<A> where A:LayoutAnchor, M:BinaryFloatingPoint {
    return .init(anchor: rhs, multiplier: CGFloat(lhs))
}

/// Operation setting a layout multiplier (right handside) and the layout anchor (left handside).
/// - parameter lhs: The anchor for the layout expression.
/// - parameter rhs: The multiplier for the layout expression.
/// - return: A layout expression with the default values and the given anchor and multiplier.
public func * <A,M>(lhs: A, rhs: M) -> LayoutAnchoredExpression<A> where A:LayoutAnchor, M:BinaryFloatingPoint {
    return .init(anchor: lhs, multiplier: CGFloat(rhs))
}

/// Operation setting a layout multiplier (right handside) and the layout anchor (left handside).
/// - parameter lhs: The anchor for the layout expression.
/// - parameter rhs: The multiplier for the layout expression.
/// - return: A layout expression with the default values and the given anchor and multiplier.
public func / <A,M>(lhs: A, rhs: M) -> LayoutAnchoredExpression<A> where A:LayoutAnchor, M:BinaryFloatingPoint {
    return .init(anchor: lhs, multiplier: CGFloat(1) / CGFloat(rhs))
}

/// Operation setting a layout constant (right handside) and the layout anchor (left handside).
/// - parameter lsh: The anchor for the layout expression.
/// - parameter rhs: The constant for the layout expression.
/// - return: A layout expression with the default values and the given anchor and constant.
public func + <A>(lhs: A, rhs: A.Constant) -> LayoutAnchoredExpression<A> where A:LayoutAnchor {
    return .init(anchor: lhs, constant: rhs)
}

/// Operation setting a layout constant (right handside) and the layout anchor (left handside).
/// - parameter lsh: The anchor for the layout expression.
/// - parameter rhs: The constant for the layout expression.
/// - return: A layout expression with the default values and the given anchor and constant.
public func - <A>(lhs: A, rhs: A.Constant) -> LayoutAnchoredExpression<A> where A:LayoutAnchor {
    return .init(anchor: lhs, constant: -rhs)
}

// MARK: - Expression & Constants

/// Operation adding the passed constant to the receiving layout expression.
/// - parameter lhs: The affected layout expression.
/// - parameter rhs: The constant to be added to the receiving expression.
internal func += <A>(lhs: inout LayoutAnchoredExpression<A>, rhs: A.Constant) where A:LayoutAnchor {
    lhs.constant += rhs
}

/// Operation subtracting the passed constant to the receiving layout expression.
/// - parameter lhs: The affected layout expression.
/// - parameter rhs: The constant to be subtracted to the receiving expression.
internal func -= <A>(lhs: inout LayoutAnchoredExpression<A>, rhs: A.Constant) where A:LayoutAnchor {
    lhs.constant -= rhs
}

/// Operation adding a constant to a layout, returning the result (as a different instance).
/// - parameter lhs: The receiving layout expression.
/// - parameter rhs: The constant to be added to the expression.
/// - returns: A duplication of `lhs` with the constant addition.
public func + <A>(lhs: LayoutAnchoredExpression<A>, rhs: A.Constant) -> LayoutAnchoredExpression<A> where A:LayoutAnchor {
    var result = lhs
    result += rhs
    return result
}

/// Operation subtracting a constant to a layout, returning the result (as a different instance).
/// - parameter lhs: The receiving layout expression.
/// - parameter rhs: The constant to be subtracted to the expression.
/// - returns: A duplication of `lhs` with the constant subtraction.
public func - <A>(lhs: LayoutAnchoredExpression<A>, rhs: A.Constant) -> LayoutAnchoredExpression<A> where A:LayoutAnchor {
    var result = lhs
    result -= rhs
    return result
}

// MARK: - LayoutExpressions & Priority

/// Creates a layout expression with the given anchor and the given layout priority.
/// - parameter lhs: The anchor for the layout expression.
/// - parameter rhs: The priority for the layout expression.
/// - return: The newly created layout expression.
public func ~ <A>(lhs: A, rhs: LayoutPriority) -> LayoutAnchoredExpression<A> {
    return .init(anchor: lhs, priority: rhs)
}

/// Creates a expression (duplicate of the receiving expression) and sets its priority to the given argument.
/// - parameter lhs: The layout expression being affected.
/// - parameter rhs: The priority to set to the creating expression.
/// - return: A duplication of `lhs` with the given priority.
public func ~ <A>(lhs: LayoutAnchoredExpression<A>, rhs: LayoutPriority) -> LayoutAnchoredExpression<A> {
    var result = lhs
    result.priority = rhs
    return result
}

/// Creates a layout constant expression (to be use in dimensional anchors) and sets its priority to the given argument.
/// - parameter lhs: The constant for dimensional anchors.
/// - parameter rhs: The priority to set to the creating expression.
public func ~ (lhs: CGFloat, rhs: LayoutPriority) -> LayoutConstantExpression<NSLayoutDimension> {
    return LayoutConstantExpression<NSLayoutDimension>(constant: lhs, priority: rhs)
}

/// Creates layout constant expression (to be use in size anchors) and sets its priority to the given argument.
/// - parameter lhs: The constant for size anchors
/// - parameter rhs: The priority to set to the creating expression.
public func ~ (lhs: CGSize, rhs: LayoutPriority) -> LayoutConstantExpression<LayoutSizeAnchor> {
    return LayoutConstantExpression<LayoutSizeAnchor>(constant: lhs, priority: rhs)
}
