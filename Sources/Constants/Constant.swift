#if canImport(QuartzCore)
import QuartzCore
#else
#error("CGFloat types are not supported")
#endif

/// Type used on layout LayoutExpressions to offset constraints.
public protocol LayoutConstant {
    /// Initializes the constants with the default values (i.e. 0s)
    init()
    /// Operation adding two constants together.
    static func + (lhs: Self, rhs: Self) -> Self
    /// Operation adding the right handside constant to the left handside constant.
    static func += (lhs: inout Self, rhs: Self)
    /// Operation negating the receiving constant.
    prefix static func - (operand: Self) -> Self
    /// Operation subtraction two constants.
    static func - (lhs: Self, rhs: Self) -> Self
    /// Operation subtracting the right handside constant to the left handside constant.
    static func -= (lhs: inout Self, rhs: Self)
}

/// A layout constant formed by several other constants.
public protocol LayoutConstantGroup: LayoutConstant {
    /// The members of the layout constant group.
    associatedtype Members
    /// The value is copied to all members.
    init(all value: CGFloat)
    /// Returns all members of the constant group.
    var all: Members { get }
    /// Modify the receiving constant group with new members.
    /// - parameter members: The members replacing the currently stored members.
    mutating func set(with members: Members)
    /// Perform the given operation in two constants members.
    /// - parameter lhs: The members of a constant operating on the operation's left handside.
    /// - parameter operator: The operation to be applied for each single member.
    /// - parameter rhs: The members of a constant operating on the operation's right handside.
    static func operate(_ lhs: Self.Members, _ operator: (CGFloat,CGFloat)->CGFloat, _ rhs: Self.Members) -> Self.Members
}

extension LayoutConstantGroup {
    public static func + (lhs: Self, rhs: Self) -> Self {
        var result: Self = .init()
        result.set(with: operate(lhs.all, +, rhs.all))
        return result
    }
    
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.set(with: operate(lhs.all, +, rhs.all))
    }
    
    public prefix static func - (operand: Self) -> Self {
        var result: Self = .init()
        result.set(with: operate(result.all, -, operand.all))
        return result
    }
    
    public static func - (lhs: Self, rhs: Self) -> Self {
        var result: Self = .init()
        result.set(with: operate(lhs.all, -, rhs.all))
        return result
    }
    
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.set(with: operate(lhs.all, -, rhs.all))
    }
}

extension LayoutConstantGroup where Self.Members == (CGFloat, CGFloat) {
    public static func operate(_ lhs: Self.Members, _ operation: (CGFloat,CGFloat)->CGFloat, _ rhs: Self.Members) -> Self.Members {
        var result: Members
        result.0 = operation(lhs.0, rhs.0)
        result.1 = operation(lhs.1, rhs.1)
        return result
    }
}

extension LayoutConstantGroup where Self.Members == (CGFloat, CGFloat, CGFloat, CGFloat) {
    public static func operate(_ lhs: Self.Members, _ operation: (CGFloat,CGFloat)->CGFloat, _ rhs: Self.Members) -> Self.Members {
        var result: Members
        result.0 = operation(lhs.0, rhs.0)
        result.1 = operation(lhs.1, rhs.1)
        result.2 = operation(lhs.2, rhs.2)
        result.3 = operation(lhs.3, rhs.3)
        return result
    }
}
