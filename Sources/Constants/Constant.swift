#if canImport(QuartzCore)
import QuartzCore
#else
#error("CGFloat types are not supported")
#endif

/// Type used on layout Expressions to offset constraints.
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
public protocol LayoutConstantGroup: LayoutConstant, Sequence where
            Self.Element == CGFloat {
    /// The value is copied to all members.
    init(_ value: CGFloat)
    /// Initializes the constant from a sequence.
    ///
    /// Zero will be paste on sequences that are not long enough.
    init<S>(_ sequence: S) where S:Sequence, S.Element == CGFloat
}

/// A layout constant formed by only two values.
internal protocol LayoutConstantPair: LayoutConstantGroup where
            Self.Iterator == LayoutIteratorPair<CGFloat> {
    /// Convenience initializer setting up the first and second members.
    init(_ first: CGFloat, _ second: CGFloat)
    /// Returns the stored elements as a tuple.
    var values: (CGFloat, CGFloat) { get set }
}

extension LayoutConstantPair {
    public static func + (lhs: Self, rhs: Self) -> Self {
        let (left, right) = (lhs.values, rhs.values)
        return .init(left.0 + right.0, left.1 + right.1)
    }
    
    public static func += (lhs: inout Self, rhs: Self) {
        let (left, right) = (lhs.values, rhs.values)
        let first  = left.0 + right.0
        let second = left.1 + right.1
        lhs.values = (first, second)
    }
    
    public prefix static func - (operand: Self) -> Self {
        let values = operand.values
        return .init(-values.0, -values.1)
    }
    
    public static func - (lhs: Self, rhs: Self) -> Self {
        let (left, right) = (lhs.values, rhs.values)
        return .init(left.0 - right.0, left.1 - right.1)
    }
    
    public static func -= (lhs: inout Self, rhs: Self) {
        let (left, right) = (lhs.values, rhs.values)
        let first  = left.0 - right.0
        let second = left.1 - right.1
        lhs.values = (first, second)
    }
    
    public func makeIterator() -> Self.Iterator {
        return .init(values: self.values)
    }
    
    public init() {
        self.init(0, 0)
    }
    
    public init(_ value: CGFloat) {
        self.init(value, value)
    }
    
    public init<S>(_ sequence: S) where S : Sequence, S.Element == CGFloat {
        var iterator = sequence.makeIterator()
        self.init(iterator.next() ?? 0, iterator.next() ?? 0)
    }
}

/// A layout constant formed by only four values.
internal protocol LayoutConstantQuartet: LayoutConstantGroup where
Self.Iterator == LayoutIteratorQuartet<CGFloat> {
    /// Convenience initializer setting up the first and second members.
    init(_ first: CGFloat, _ second: CGFloat, _ third: CGFloat, _ fourth: CGFloat)
    /// Returns the stored elements as a tuple.
    var values: (CGFloat, CGFloat, CGFloat, CGFloat) { get set }
}

extension LayoutConstantQuartet {
    public static func + (lhs: Self, rhs: Self) -> Self {
        let (left, right) = (lhs.values, rhs.values)
        return .init(left.0 + right.0, left.1 + right.1, left.2 + right.2, left.3 + right.3)
    }
    
    public static func += (lhs: inout Self, rhs: Self) {
        let (left, right) = (lhs.values, rhs.values)
        let first  = left.0 + right.0
        let second = left.1 + right.1
        let third  = left.2 + right.2
        let fourth = left.3 + right.3
        lhs.values = (first, second, third, fourth)
    }
    
    public prefix static func - (operand: Self) -> Self {
        let values = operand.values
        return .init(-values.0, -values.1, values.2, values.3)
    }
    
    public static func - (lhs: Self, rhs: Self) -> Self {
        let (left, right) = (lhs.values, rhs.values)
        return .init(left.0 - right.0, left.1 - right.1, left.2 - right.2, left.3 - right.3)
    }
    
    public static func -= (lhs: inout Self, rhs: Self) {
        let (left, right) = (lhs.values, rhs.values)
        let first  = left.0 - right.0
        let second = left.1 - right.1
        let third  = left.2 - right.2
        let fourth = left.3 - right.3
        lhs.values = (first, second, third, fourth)
    }
    
    public func makeIterator() -> Self.Iterator {
        return .init(values: self.values)
    }
    
    public init() {
        self.init(0, 0, 0, 0)
    }
    
    public init(_ value: CGFloat) {
        self.init(value, value, value, value)
    }
    
    public init<S>(_ sequence: S) where S : Sequence, S.Element == CGFloat {
        var iterator = sequence.makeIterator()
        self.init(iterator.next() ?? 0, iterator.next() ?? 0, iterator.next() ?? 0, iterator.next() ?? 0)
    }
}
