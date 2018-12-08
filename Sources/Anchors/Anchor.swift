#if canImport(QuartzCore)
import QuartzCore
#else
#error("CGFloat types are not supported")
#endif

/// Concrete types conforming to this protocol represent a layout anchor used in Autolayout.
public protocol LayoutAnchor {
    /// The type of constant associated with the given layout anchor.
    associatedtype Constant: LayoutConstant
    /// The constraint type generated by the receiving anchor.
    associatedtype Constraint: LayoutConstraint
    
    /// Generates the constraint/s of of the equality relation between the receiving and passed anchors.
    func constraint(equalTo anchor: Self, multiplier: CGFloat?, constant: Self.Constant) -> Self.Constraint
    /// Generates the constraint/s of the "greater than" inequality relation between the receiving and passed anchors.
    func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat?, constant: Self.Constant) -> Self.Constraint
    /// Generates the constraint/s of the "less than" inequality relation between the receiving and passed anchors.
    func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat?, constant: Self.Constant) -> Self.Constraint
}

/// Layout anchor that is able to produce constraints from only layout constants.
public protocol LayoutAnchorConstant: LayoutAnchor {
    /// Generates constraints from an equality relation between the receiving anchor and a constant.
    func constraint(equalToConstant constant: Self.Constant) -> Self.Constraint
    /// Generates constraints from a "greater than" inequality relation between the receiving anchor and a constant.
    func constraint(greaterThanOrEqualToConstant constant: Self.Constant) -> Self.Constraint
    /// Generates constraints from a "less than" inequality relation between the receiving anchor and a constant.
    func constraint(lessThanOrEqualToConstant constant: Self.Constant) -> Self.Constraint
}

/// A layout anchor that produces a single layout constraint (i.e. non-aggregated).
public protocol LayoutAnchorSingle: LayoutAnchor where
            Self.Constant == CGFloat,
            Self.Constraint == NSLayoutConstraint {
}

/// A layout anchor that produces several layout constraints (i.e. aggregated).
public protocol LayoutAnchorGroup: LayoutAnchor where
            Self.Constant: LayoutConstantGroup,
            Self.Constraint: LayoutConstraintGroup {
    static var isInset: Bool { get }
}

/// An anchor internally grouping two single anchors (e.g. `SizeAnchor`, `LayoutCenterCenterAnchor`, etc.).
internal protocol LayoutAnchorPair: LayoutAnchorGroup where
            Self.Constant: LayoutConstantPair,
            Self.Constraint.Iterator == LayoutIteratorPair<NSLayoutConstraint> {
    /// The anchor type for the first single anchor.
    associatedtype AnchorA: LayoutAnchorSingle
    /// The anchor type for the second single anchor.
    associatedtype AnchorB: LayoutAnchorSingle
    /// Designated initializer for the anchor group.
    init(_ anchorA: AnchorA, _ anchorB: AnchorB)
    /// Returns all stored single anchors.
    var anchors: (AnchorA, AnchorB) { get }
}

extension LayoutAnchorPair {
    public func constraint(equalTo anchor: Self, multiplier: CGFloat?, constant: Self.Constant) -> Self.Constraint {
        let (lhs, rhs, cnt) = (self.anchors, anchor.anchors, constant.values)
        let first = lhs.0.constraint(equalTo: rhs.0, multiplier: multiplier, constant: cnt.0)
        let second = lhs.1.constraint(equalTo: rhs.1, multiplier: multiplier, constant: cnt.1)
        return Self.Constraint([first, second])!
    }
    
    public func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat?, constant: Self.Constant) -> Self.Constraint {
        let (lhs, rhs, cnt) = (self.anchors, anchor.anchors, constant.values)
        let first = lhs.0.constraint(greaterThanOrEqualTo: rhs.0, multiplier: multiplier, constant: cnt.0)
        let second = Self.isInset ? lhs.1.constraint(lessThanOrEqualTo: rhs.1, multiplier: multiplier, constant: cnt.1)
                                  : lhs.1.constraint(greaterThanOrEqualTo: rhs.1, multiplier: multiplier, constant: cnt.1)
        return Self.Constraint([first, second])!
    }
    
    public func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat?, constant: Self.Constant) -> Self.Constraint {
        let (lhs, rhs, cnt) = (self.anchors, anchor.anchors, constant.values)
        let first = lhs.0.constraint(lessThanOrEqualTo: rhs.0, multiplier: multiplier, constant: cnt.0)
        let second = Self.isInset ? lhs.1.constraint(greaterThanOrEqualTo: rhs.1, multiplier: multiplier, constant: cnt.1)
                                  : lhs.1.constraint(lessThanOrEqualTo: rhs.1, multiplier: multiplier, constant: cnt.1)
        return Self.Constraint([first, second])!
    }
}

/// An anchor internally grouping four single anchors (e.g. `EdgeAnchor`).
internal protocol LayoutAnchorQuartet: LayoutAnchorGroup where
            Self.Constant: LayoutConstantQuartet,
            Self.Constraint.Iterator == LayoutIteratorQuartet<NSLayoutConstraint> {
    /// The anchor type for the first single anchor.
    associatedtype AnchorA: LayoutAnchorSingle
    /// The anchor type for the second single anchor.
    associatedtype AnchorB: LayoutAnchorSingle
    /// The anchor type for the third single anchor.
    associatedtype AnchorC: LayoutAnchorSingle
    /// The anchor type for the fourth single anchor.
    associatedtype AnchorD: LayoutAnchorSingle
    /// Designated initializer for the anchor group.
    init(_ anchorA: AnchorA, _ anchorB: AnchorB, _ anchorC: AnchorC, _ anchorD: AnchorD)
    /// Returns all stored single anchors.
    var anchors: (AnchorA, AnchorB, AnchorC, AnchorD) { get }
}

extension LayoutAnchorQuartet {
    public func constraint(equalTo anchor: Self, multiplier: CGFloat?, constant: Self.Constant) -> Self.Constraint {
        let (lhs, rhs, cnt) = (self.anchors, anchor.anchors, constant.values)
        let first = lhs.0.constraint(equalTo: rhs.0, multiplier: multiplier, constant: cnt.0)
        let second = lhs.1.constraint(equalTo: rhs.1, multiplier: multiplier, constant: cnt.1)
        let third = lhs.2.constraint(equalTo: rhs.2, multiplier: multiplier, constant: cnt.2)
        let fourth = lhs.3.constraint(equalTo: rhs.3, multiplier: multiplier, constant: cnt.3)
        return Self.Constraint([first, second, third, fourth])!
    }
    
    public func constraint(greaterThanOrEqualTo anchor: Self, multiplier: CGFloat?, constant: Self.Constant) -> Self.Constraint {
        let (lhs, rhs, cnt) = (self.anchors, anchor.anchors, constant.values)
        let first = lhs.0.constraint(greaterThanOrEqualTo: rhs.0, multiplier: multiplier, constant: cnt.0)
        let second = lhs.1.constraint(greaterThanOrEqualTo: rhs.1, multiplier: multiplier, constant: cnt.1)
        let (third, fourth): (NSLayoutConstraint, NSLayoutConstraint)
        if Self.isInset {
            third = lhs.2.constraint(lessThanOrEqualTo: rhs.2, multiplier: multiplier, constant: cnt.2)
            fourth = lhs.3.constraint(lessThanOrEqualTo: rhs.3, multiplier: multiplier, constant: cnt.3)
        } else {
            third = lhs.2.constraint(greaterThanOrEqualTo: rhs.2, multiplier: multiplier, constant: cnt.2)
            fourth = lhs.3.constraint(greaterThanOrEqualTo: rhs.3, multiplier: multiplier, constant: cnt.3)
        }
        return Self.Constraint([first, second, third, fourth])!
    }
    
    public func constraint(lessThanOrEqualTo anchor: Self, multiplier: CGFloat?, constant: Self.Constant) -> Self.Constraint {
        let (lhs, rhs, cnt) = (self.anchors, anchor.anchors, constant.values)
        let first = lhs.0.constraint(lessThanOrEqualTo: rhs.0, multiplier: multiplier, constant: cnt.0)
        let second = lhs.1.constraint(lessThanOrEqualTo: rhs.1, multiplier: multiplier, constant: cnt.1)
        let (third, fourth): (NSLayoutConstraint, NSLayoutConstraint)
        if Self.isInset {
            third = lhs.2.constraint(greaterThanOrEqualTo: rhs.2, multiplier: multiplier, constant: cnt.2)
            fourth = lhs.3.constraint(greaterThanOrEqualTo: rhs.3, multiplier: multiplier, constant: cnt.3)
        } else {
            third = lhs.2.constraint(lessThanOrEqualTo: rhs.2, multiplier: multiplier, constant: cnt.2)
            fourth = lhs.3.constraint(lessThanOrEqualTo: rhs.3, multiplier: multiplier, constant: cnt.3)
        }
        return Self.Constraint([first, second, third, fourth])!
    }
}
