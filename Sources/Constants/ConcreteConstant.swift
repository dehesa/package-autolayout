#if canImport(UIKit)
import UIKit
public typealias EdgeInsets = UIEdgeInsets
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets
#elseif canImport(Cocoa)
import Cocoa
public typealias EdgeInsets = NSEdgeInsets
#warning("TODO: Create a DirectionalEdgeInsets for macOS")
#else
#error("OS not supported")
#endif

extension CGFloat: LayoutConstant {
    
}

extension CGPoint: LayoutConstantGroup {
    var all: (CGFloat, CGFloat) {
        return (self.x, self.y)
    }
    
    mutating func set(with members: (CGFloat, CGFloat)) {
        self.x = members.0
        self.y = members.1
    }
}

extension CGSize: LayoutConstantGroup {
    var all: (CGFloat, CGFloat) {
        return (self.width, self.height)
    }
    
    mutating func set(with members: (CGFloat, CGFloat)) {
        self.width = members.0
        self.height = members.1
    }
}

/// Represents a a vertical shift for the top and bottom vertical anchors.
public struct VerticalInsets: LayoutConstantGroup {
    /// The amount of points a vertical anchor will be shifted (from the top).
    var top: CGFloat
    /// The amount of points a vertical anchor will be shifted (from the bottom).
    var bottom: CGFloat
    
    public init() {
        self.init(top: 0, bottom: 0)
    }
    /// Designated initializer providing the top and bottom constant.
    /// - parameter top: The amount of points a vertical anchor will be shifted (from the top).
    /// - parameter bottom: The amount of points a vertical anchor will be shifted (from the bottom).
    public init(top: CGFloat, bottom: CGFloat) {
        (self.top, self.bottom) = (top, bottom)
    }
    
    var all: (CGFloat, CGFloat) {
        return (self.top, self.bottom)
    }
    
    mutating func set(with members: (CGFloat, CGFloat)) {
        self.top = members.0
        self.bottom = members.1
    }
}

/// Represents a horizontal shift for the left and right anchors.
public struct HorizontalInsets: LayoutConstantGroup {
    /// The amount of points a horizontal anchor will be shifted (from the left).
    var left: CGFloat
    /// The amount of points a horizontal anchor will be shifted (from the right).
    var right: CGFloat
    
    public init() {
        self.init(left: 0, right: 0)
    }
    
    /// Designated initializer providing the left and right constant.
    /// - parameter top: The amount of points a horizontal anchor will be shifted (from the left).
    /// - parameter bottom: The amount of points a horizontal anchor will be shifted (from the right).
    public init(left: CGFloat, right: CGFloat) {
        (self.left, self.right) = (left, right)
    }
    
    var all: (CGFloat, CGFloat) {
        return (self.left, self.right)
    }
    
    mutating func set(with members: (CGFloat, CGFloat)) {
        self.left = members.0
        self.right = members.1
    }
}

/// Represents a horizontal shift for the leading and trailing anchors.
public struct DirectionalInsets: LayoutConstantGroup {
    /// The amount of points a horizontal anchor will be shifted (from the leading side).
    var leading: CGFloat
    /// The amount of points a horizontal anchor will be shifted (from the trailing side).
    var trailing: CGFloat
    
    public init() {
        self.init(leading: 0, trailing: 0)
    }
    
    /// Designated initializer providing the leading and trailing constant.
    /// - parameter top: The amount of points a horizontal anchor will be shifted (from the leading side).
    /// - parameter bottom: The amount of points a horizontal anchor will be shifted (from the trailing side).
    public init(leading: CGFloat, trailing: CGFloat) {
        (self.leading, self.trailing) = (leading, trailing)
    }
    
    var all: (CGFloat, CGFloat) {
        return (self.leading, self.trailing)
    }
    
    mutating func set(with members: (CGFloat, CGFloat)) {
        self.leading = members.0
        self.trailing = members.1
    }
}

/// Represents a horizontal and vertical shift for the top, left, bottom, right anchors.
extension EdgeInsets: LayoutConstantGroup {
    var all: (CGFloat, CGFloat, CGFloat, CGFloat) {
        return (self.top, self.left, self.bottom, self.right)
    }
    
    mutating func set(with members: (CGFloat, CGFloat, CGFloat, CGFloat)) {
        self.top = members.0
        self.left = members.1
        self.bottom = members.2
        self.right = members.3
    }
}

/// Represents a horizontal and vertical shift for the top, leading, bottom, trailing anchors.
extension DirectionalEdgeInsets: LayoutConstantGroup {
    var all: (CGFloat, CGFloat, CGFloat, CGFloat) {
        return (self.top, self.leading, self.bottom, self.trailing)
    }
    
    mutating func set(with members: (CGFloat, CGFloat, CGFloat, CGFloat)) {
        self.top = members.0
        self.leading = members.1
        self.bottom = members.2
        self.trailing = members.3
    }
}
