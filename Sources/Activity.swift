// MARK: Postfix

postfix operator ↑

/// Postfix operation activating the constraint or group of constraints affected by the operator.
@discardableResult
public postfix func ↑ <C>(lhs: C) -> C where C:LayoutConstraint {
    return lhs.activating(true)
}

postfix operator ↓

/// Postfix operation disabling the constraint or group of constraints affected by the operator.
@discardableResult
public postfix func ↓ <C>(lhs: C) -> C where C:LayoutConstraint {
    return lhs.activating(false)
}

// MARK: - Infix

infix operator ↑ : LogicalConjunctionPrecedence

/// Infix operation activing and identifying the constraint or group of constraints on the operation's left handside.
/// - parameter lhs: The constraint/s to be actuated upon.
/// - parameter rhs: The identifiers to be assigned to the constraint/s.
/// - returns: The modifyied `lhs`.
@discardableResult
public func ↑ <C>(lhs: C, rhs: C.Identifier) -> C where C:LayoutConstraint {
    return lhs.identifying(rhs).activating(true)
}

/// Infix operation activating and identifying the constraint or group of constraint on the operation's left handside.
/// - parameter lhs: The constraint/s to be actuated upon.
/// - parameter rhs: The root identifier to be preppended and the identifiers to be postppended to the constraint/s.
/// - returns: The modifyied `lhs`.
@discardableResult
public func ↑ <C>(lhs: C, rhs: (String, C.Identifier)) -> C where C:LayoutConstraintGroup {
    return lhs.identifying(root: rhs.0, rhs.1).activating(true)
}

infix operator ↓ : LogicalConjunctionPrecedence

/// Infix operation disabling and idenfying the constraint or group of constraints on the operation's left handside.
/// - parameter lhs: The constraint/s to be actuated upon.
/// - parameter rhs: The identifiers to be assigned to the constraint/s.
/// - returns: The modifyied `lhs`.
@discardableResult
public func ↓ <C>(lhs: C, rhs: C.Identifier) -> C where C:LayoutConstraint {
    return lhs.identifying(rhs).activating(false)
}

/// Infix operation disabling and idenfying the constraint or group of constraints on the operation's left handside.
/// - parameter lhs: The constraint/s to be actuated upon.
/// - parameter rhs: The root identifier to be preppended and the identifiers to be postppended to the constraint/s.
/// - returns: The modifyied `lhs`.
@discardableResult
public func ↓ <C>(lhs: C, rhs: (String, C.Identifier)) -> C where C:LayoutConstraintGroup {
    return lhs.identifying(root: rhs.0, rhs.1).activating(true)
}
