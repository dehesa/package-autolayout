#if os(iOS) || os(tvOS)
import UIKit
public typealias EdgeInsets = UIEdgeInsets
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets
#elseif os(macOS)
import Cocoa
public typealias EdgeInsets = NSEdgeInsets
#warning("TODO: Create a DirectionalEdgeInsets for macOS")
#else
#error("OS not supported")
#endif

extension CGFloat: LayoutConstant {
    
}

extension CGPoint: LayoutConstant, LayoutConstantPair {
    init(_ first: CGFloat, _ second: CGFloat) {
        self.init(x: first, y: second)
    }
    
    var first: CGFloat {
        get { return self.x }
        set { self.x = newValue }
    }
    
    var second: CGFloat {
        get { return self.y }
        set { self.y = newValue }
    }
}

extension CGSize: LayoutConstant, LayoutConstantPair {
    init(_ first: CGFloat, _ second: CGFloat) {
        self.init(width: first, height: second)
    }
    
    var first: CGFloat {
        get { return self.width }
        set { self.width = newValue }
    }
    
    var second: CGFloat {
        get { return self.height }
        set { self.height = newValue }
    }
}

/// Represents a a vertical shift for the top and bottom vertical anchors.
public struct VerticalInsets: LayoutConstant, LayoutConstantPair {
    var top: CGFloat, bottom: CGFloat
    
    public init() {
        (self.top, self.bottom) = (0, 0)
    }
    
    public init(top: CGFloat, bottom: CGFloat) {
        (self.top, self.bottom) = (top, bottom)
    }
    
    init(_ first: CGFloat, _ second: CGFloat) {
        (self.top, self.bottom) = (first, second)
    }
    
    var first: CGFloat {
        get { return self.top }
        set { self.top = newValue }
    }
    
    var second: CGFloat {
        get { return self.bottom }
        set { self.bottom = newValue }
    }
}

/// Represents a horizontal shift for the left and right anchors.
public struct HorizontalInsets: LayoutConstant, LayoutConstantPair {
    var left: CGFloat, right: CGFloat
    
    public init() {
        (self.left, self.right) = (0, 0)
    }
    
    public init(left: CGFloat, right: CGFloat) {
        (self.left, self.right) = (left, right)
    }
    
    init(_ first: CGFloat, _ second: CGFloat) {
        (self.left, self.right) = (first, second)
    }
    
    var first: CGFloat {
        get { return self.left }
        set { self.left = newValue }
    }
    
    var second: CGFloat {
        get { return self.right }
        set { self.right = newValue }
    }
}

/// Represents a horizontal shift for the leading and trailing anchors.
public struct DirectionalInsets: LayoutConstant, LayoutConstantPair {
    var leading: CGFloat, trailing: CGFloat
    
    public init() {
        (self.leading, self.trailing) = (0, 0)
    }
    
    public init(leading: CGFloat, trailing: CGFloat) {
        (self.leading, self.trailing) = (leading, trailing)
    }
    
    init(_ first: CGFloat, _ second: CGFloat) {
        (self.leading, self.trailing) = (first, second)
    }
    
    var first: CGFloat {
        get { return self.leading }
        set { self.leading = newValue }
    }
    
    var second: CGFloat {
        get { return self.trailing }
        set { self.trailing = newValue }
    }
}

/// Represents a horizontal and vertical shift for the top, left, bottom, right anchors.
extension EdgeInsets: LayoutConstant, LayoutConstantQuartet {
    init(_ first: CGFloat, _ second: CGFloat, _ third: CGFloat, _ fourth: CGFloat) {
        self.init(top: first, left: second, bottom: third, right: fourth)
    }
    
    var first: CGFloat {
        get { return self.top }
        set { self.top = newValue }
    }
    
    var second: CGFloat {
        get { return self.left }
        set { self.left = newValue }
    }
    
    var third: CGFloat {
        get { return self.bottom }
        set { self.bottom = newValue }
    }
    
    var fourth: CGFloat {
        get { return self.right }
        set { self.right = newValue }
    }
}

/// Represents a horizontal and vertical shift for the top, leading, bottom, trailing anchors.
extension DirectionalEdgeInsets: LayoutConstant, LayoutConstantQuartet {
    init(_ first: CGFloat, _ second: CGFloat, _ third: CGFloat, _ fourth: CGFloat) {
        self.init(top: first, leading: second, bottom: third, trailing: fourth)
    }
    
    var first: CGFloat {
        get { return self.top }
        set { self.top = newValue }
    }
    
    var second: CGFloat {
        get { return self.leading }
        set { self.leading = newValue }
    }
    
    var third: CGFloat {
        get { return self.bottom }
        set { self.bottom = newValue }
    }
    
    var fourth: CGFloat {
        get { return self.trailing }
        set { self.trailing = newValue }
    }
}
