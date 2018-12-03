#if canImport(QuartzCore)
import QuartzCore
#else
#error("CGFloat types are not supported")
#endif

/// Type used on layout LayoutExpressions to offset constraints.
public protocol LayoutConstant {
    init()
    
    init(_ value: CGFloat)
    
    static func + (lhs: Self, rhs: Self) -> Self
    
    static func += (lhs: inout Self, rhs: Self)
    
    prefix static func - (operand: Self) -> Self
    
    static func - (lhs: Self, rhs: Self) -> Self
    
    static func -= (lhs: inout Self, rhs: Self)
}

/// A type of layout constraint containing two values.
internal protocol LayoutConstantPair {
    var first: CGFloat { get set }
    var second: CGFloat { get set }
    
    init(_ first: CGFloat, _ second: CGFloat)
}

extension LayoutConstantPair {
    public init(_ value: CGFloat) {
        self.init(value, value)
    }
    
    public static func + (lhs: Self, rhs: Self) -> Self {
        return .init(lhs.first + rhs.first, lhs.second + rhs.second)
    }
    
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.first += rhs.first
        lhs.second += rhs.second
    }
    
    public prefix static func - (operand: Self) -> Self {
        return .init(-operand.first, -operand.second)
    }
    
    public static func - (lhs: Self, rhs: Self) -> Self {
        return .init(lhs.first - rhs.first, lhs.second - rhs.second)
    }
    
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.first -= rhs.first
        lhs.second -= rhs.second
    }
}

/// A type of layout constraint containing four values.
internal protocol LayoutConstantQuartet {
    var first: CGFloat { get set }
    var second: CGFloat { get set }
    var third: CGFloat { get set }
    var fourth: CGFloat { get set }
    
    init(_ first: CGFloat, _ second: CGFloat, _ third: CGFloat, _ fourth: CGFloat)
}

extension LayoutConstantQuartet {
    public init(_ value: CGFloat) {
        self.init(value, value, value, value)
    }
    
    public static func + (lhs: Self, rhs: Self) -> Self {
        return .init(lhs.first + rhs.first, lhs.second + rhs.second, lhs.third + rhs.third, lhs.fourth + rhs.fourth)
    }
    
    public static func += (lhs: inout Self, rhs: Self) {
        lhs.first += rhs.first
        lhs.second += rhs.second
        lhs.third += rhs.third
        lhs.fourth += rhs.fourth
    }
    
    public prefix static func - (operand: Self) -> Self {
        return .init(-operand.first, -operand.second, -operand.third, -operand.fourth)
    }
    
    public static func - (lhs: Self, rhs: Self) -> Self {
        return .init(lhs.first - rhs.first, lhs.second - rhs.second, lhs.third - rhs.third, lhs.fourth - rhs.fourth)
    }
    
    public static func -= (lhs: inout Self, rhs: Self) {
        lhs.first -= rhs.first
        lhs.second -= rhs.second
        lhs.third -= rhs.third
        lhs.fourth -= rhs.fourth
    }
}
