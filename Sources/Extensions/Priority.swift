#if os(iOS) || os(tvOS)
import UIKit
public typealias Priority = UILayoutPriority
#elseif os(macOS)
import Cocoa
public typealias Priority = NSLayoutConstraint.Priority
#else
#error("OS not supported")
#endif

extension Priority: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    /// The priority level with which a button resists compressing its content.
    public static var high: UILayoutPriority { return .defaultHigh }
    /// The priority level at which a button hugs its contents horizontally.
    public static var low: UILayoutPriority { return .defaultLow }
    
    /// Creates a layout priority with a numeric value (from 1 to 1000).
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Float(value))
    }
    
    /// Creates a layout priority with a numeric value (from 1 to 1000).
    public init(floatLiteral value: FloatLiteralType) {
        self.init(Float(value))
    }
    
    /// Creates a layout priority with a numeric value (from 1 to 1000).
    public init<I>(_ value: I) where I:BinaryInteger {
        self.init(Float(value))
    }
    
    /// Creates a layout priority with a numeric value (from 1 to 1000).
    public init<F>(_ value: F) where F:BinaryFloatingPoint {
        self.init(Float(value))
    }
}

@discardableResult
public func + <C>(lhs: Priority, rhs: C) -> Priority where C:BinaryInteger {
    return Priority(lhs.rawValue + Float(rhs))
}

@discardableResult
public func + <C>(lhs: Priority, rhs: C) -> Priority
    where C:BinaryFloatingPoint {
        return Priority(lhs.rawValue + Float(rhs))
}

@discardableResult
public func - <C>(lhs: Priority, rhs: C) -> Priority
    where C:BinaryInteger {
    return Priority(lhs.rawValue - Float(rhs))
}

@discardableResult
public func - <C>(lhs: Priority, rhs: C) -> Priority
    where C:BinaryFloatingPoint {
        return Priority(lhs.rawValue - Float(rhs))
}

infix operator ~ : RangeFormationPrecedence

@discardableResult
public func ~ (lhs: NSLayoutConstraint, rhs: Priority) -> NSLayoutConstraint {
    let result = lhs
    result.priority = rhs
    return result
}
