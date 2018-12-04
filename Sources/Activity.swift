// MARK: Postfix

postfix operator ↑

@discardableResult
public postfix func ↑ <C>(lhs: C) -> C where C:LayoutConstraint {
    return lhs.activating(true)
}

postfix operator ↓

@discardableResult
public postfix func ↓ <C>(lhs: C) -> C where C:LayoutConstraint {
    return lhs.activating(false)
}

// MARK: - Infix

infix operator ↑ : LogicalConjunctionPrecedence

@discardableResult
public func ↑ <C>(lhs: C, rhs: C.Identifier) -> C where C:LayoutConstraint {
    return lhs.identifying(rhs).activating(true)
}

@discardableResult
public func ↑ <C>(lhs: C, rhs: (String, C.Identifier)) -> C where C:LayoutConstraintGroup {
    return lhs.identifying(root: rhs.0, rhs.1).activating(true)
}

infix operator ↓ : LogicalConjunctionPrecedence

@discardableResult
public func ↓ <C>(lhs: C, rhs: C.Identifier) -> C where C:LayoutConstraint {
    return lhs.identifying(rhs).activating(false)
}

@discardableResult
public func ↓ <C>(lhs: C, rhs: (String, C.Identifier)) -> C where C:LayoutConstraintGroup {
    return lhs.identifying(root: rhs.0, rhs.1).activating(true)
}
