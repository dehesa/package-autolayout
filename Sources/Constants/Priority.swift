#if canImport(UIKit)
import UIKit
public typealias LayoutPriority = UILayoutPriority
#elseif canImport(Cocoa)
import Cocoa
public typealias LayoutPriority = NSLayoutConstraint.Priority
#else
#error("OS not supported")
#endif

extension LayoutPriority: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    /// The priority level with which a button resists compressing its content.
    public static var high: UILayoutPriority { return .defaultHigh }
    /// The priority level at which a button hugs its contents horizontally.
    public static var low: UILayoutPriority { return .defaultLow }
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(Float(value))
    }
    
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

/// Operation adding two priorities together and returning it as a new layout priority.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority addition.
@discardableResult
public func + <C>(lhs: LayoutPriority, rhs: C) -> LayoutPriority where C:BinaryInteger {
    return LayoutPriority(lhs.rawValue + Float(rhs))
}

/// Operation adding two priorities together and returning it as a new layout priority.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority addition.
@discardableResult
public func + <C>(lhs: LayoutPriority, rhs: C) -> LayoutPriority where C:BinaryFloatingPoint {
        return LayoutPriority(lhs.rawValue + Float(rhs))
}

/// Operation subtracting two priorities together and returning it as a new layout priority.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority subtraction.
@discardableResult
public func - <C>(lhs: LayoutPriority, rhs: C) -> LayoutPriority where C:BinaryInteger {
    return LayoutPriority(lhs.rawValue - Float(rhs))
}

/// Operation subtracting two priorities together and returning it as a new layout priority.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority subtraction.
@discardableResult
public func - <C>(lhs: LayoutPriority, rhs: C) -> LayoutPriority where C:BinaryFloatingPoint {
        return LayoutPriority(lhs.rawValue - Float(rhs))
}

infix operator ~ : RangeFormationPrecedence

/// Operation setting the priority of a receiving layout constraint.
/// - parameter lhs: The priority on the left handside.
/// - parameter rhs: The priority (as a number) on the right handside.
/// - returns: The result of the priority subtraction.
@discardableResult
public func ~ <C>(lhs: C, rhs: LayoutPriority) -> C where C:LayoutConstraint {
    return lhs.prioritizing(rhs)
}
