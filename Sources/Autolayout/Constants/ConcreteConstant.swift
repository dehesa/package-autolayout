#if canImport(UIKit)
import UIKit
public typealias EdgeInsets = UIEdgeInsets
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets
#elseif canImport(Cocoa)
import Cocoa
public typealias EdgeInsets = NSEdgeInsets
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets
#else
#error("OS not supported")
#endif

extension CGFloat: LayoutConstant {
    
}

extension CGPoint: LayoutConstantPair {
    public typealias Iterator = LayoutIteratorPair<CGFloat>

    init(_ first: CGFloat, _ second: CGFloat) {
        self.init(x: first, y: second)
    }
    
    public init(_ value: CGFloat) {
        self.init(value, value)
    }
    
    var values: (CGFloat, CGFloat) {
        get { return (self.x, self.y) }
        set { self.x = newValue.0; self.y = newValue.1 }
    }
}

extension CGSize: LayoutConstantPair {
    public typealias Iterator = LayoutIteratorPair<CGFloat>
    
    init(_ first: CGFloat, _ second: CGFloat) {
        self.init(width: first, height: second)
    }
    
    public init(_ value: CGFloat) {
        self.init(value, value)
    }
    
    var values: (CGFloat, CGFloat) {
        get { return (self.width, self.height) }
        set { self.width = newValue.0; self.height = newValue.1 }
    }
}

/// Represents a a vertical shift for the top and bottom vertical anchors.
public struct VerticalInsets: LayoutConstantPair {
    public typealias Iterator = LayoutIteratorPair<CGFloat>
    /// The amount of points a vertical anchor will be shifted (from the top).
    var top: CGFloat
    /// The amount of points a vertical anchor will be shifted (from the bottom).
    var bottom: CGFloat

    /// Designated initializer providing the top and bottom constant.
    /// - parameter top: The amount of points a vertical anchor will be shifted (from the top).
    /// - parameter bottom: The amount of points a vertical anchor will be shifted (from the bottom).
    public init(top: CGFloat, bottom: CGFloat) {
        (self.top, self.bottom) = (top, bottom)
    }
    
    init(_ first: CGFloat, _ second: CGFloat) {
        self.init(top: first, bottom: second)
    }
    
    public init(_ value: CGFloat) {
        self.init(value, -value)
    }
    
    var values: (CGFloat, CGFloat) {
        get { return (self.top, self.bottom) }
        set { self.top = newValue.0; self.bottom = newValue.1 }
    }
}

/// Represents a horizontal shift for the left and right anchors.
public struct HorizontalInsets: LayoutConstantPair {
    public typealias Iterator = LayoutIteratorPair<CGFloat>
    /// The amount of points a horizontal anchor will be shifted (from the left).
    var left: CGFloat
    /// The amount of points a horizontal anchor will be shifted (from the right).
    var right: CGFloat
    
    /// Designated initializer providing the left and right constant.
    /// - parameter top: The amount of points a horizontal anchor will be shifted (from the left).
    /// - parameter bottom: The amount of points a horizontal anchor will be shifted (from the right).
    public init(left: CGFloat, right: CGFloat) {
        (self.left, self.right) = (left, right)
    }
    
    init(_ first: CGFloat, _ second: CGFloat) {
        self.init(left: first, right: second)
    }
    
    public init(_ value: CGFloat) {
        self.init(value, -value)
    }
    
    var values: (CGFloat, CGFloat) {
        get { return (self.left, self.right) }
        set { self.left = newValue.0; self.right = newValue.1 }
    }
}

/// Represents a horizontal shift for the leading and trailing anchors.
public struct DirectionalInsets: LayoutConstantPair {
    public typealias Iterator = LayoutIteratorPair<CGFloat>
    /// The amount of points a horizontal anchor will be shifted (from the leading side).
    var leading: CGFloat
    /// The amount of points a horizontal anchor will be shifted (from the trailing side).
    var trailing: CGFloat
    
    /// Designated initializer providing the leading and trailing constant.
    /// - parameter top: The amount of points a horizontal anchor will be shifted (from the leading side).
    /// - parameter bottom: The amount of points a horizontal anchor will be shifted (from the trailing side).
    public init(leading: CGFloat, trailing: CGFloat) {
        (self.leading, self.trailing) = (leading, trailing)
    }
    
    init(_ first: CGFloat, _ second: CGFloat) {
        self.init(leading: first, trailing: second)
    }
    
    public init(_ value: CGFloat) {
        self.init(value, -value)
    }
    
    var values: (CGFloat, CGFloat) {
        get { return (self.leading, self.trailing) }
        set { self.leading = newValue.0; self.trailing = newValue.1 }
    }
}

/// Represents a horizontal and vertical shift for the top, left, bottom, right anchors.
extension EdgeInsets: LayoutConstantQuartet {
    public typealias Iterator = LayoutIteratorQuartet<CGFloat>
    
    init(_ first: CGFloat, _ second: CGFloat, _ third: CGFloat, _ fourth: CGFloat) {
        self.init(top: first, left: second, bottom: third, right: fourth)
    }
    
    public init(_ value: CGFloat) {
        self.init(value, value, -value, -value)
    }
    
    var values: (CGFloat, CGFloat, CGFloat, CGFloat) {
        get { return (self.top, self.left, self.bottom, self.right) }
        set { self.top = newValue.0; self.left = newValue.1; self.bottom = newValue.2; self.right = newValue.3 }
    }
}

/// Represents a horizontal and vertical shift for the top, leading, bottom, trailing anchors.
extension DirectionalEdgeInsets: LayoutConstantQuartet {
    public typealias Iterator = LayoutIteratorQuartet<CGFloat>
    
    init(_ first: CGFloat, _ second: CGFloat, _ third: CGFloat, _ fourth: CGFloat) {
        self.init(top: first, leading: second, bottom: third, trailing: fourth)
    }
    
    public init(_ value: CGFloat) {
        self.init(value, value, -value, -value)
    }
    
    var values: (CGFloat, CGFloat, CGFloat, CGFloat) {
        get { return (self.top, self.leading, self.bottom, self.trailing) }
        set { self.top = newValue.0; self.leading = newValue.1; self.bottom = newValue.2; self.trailing = newValue.3 }
    }
}

