#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#else
#error("OS not supported")
#endif

// MARK: - Single Anchors

extension NSLayoutDimension: LayoutAnchorSingle {
    public func constraint(equalTo anchor: NSLayoutDimension, _ priority: LayoutPriority, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
        let result = self.constraint(equalTo: anchor, multiplier: multiplier ?? 1, constant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, _ priority: LayoutPriority, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
        let result = self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier ?? 1, constant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, _ priority: LayoutPriority, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
        let result = self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier ?? 1, constant: constant)
        result.priority = priority
        return result
    }
}

extension NSLayoutDimension: LayoutAnchorSimple {
    public func constraint(equalTo constant: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        let result = self.constraint(equalToConstant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(greaterThanOrEqualTo constant: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        let result = self.constraint(greaterThanOrEqualToConstant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(lessThanOrEqualTo constant: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        let result = self.constraint(lessThanOrEqualToConstant: constant)
        result.priority = priority
        return result
    }
}

extension NSLayoutXAxisAnchor: LayoutAnchorSingle {
    public func constraint(equalTo anchor: NSLayoutXAxisAnchor, _ priority: LayoutPriority, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
        return self.constraint(equalTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier, priority: priority)
    }
    
    public func constraint(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, _ priority: LayoutPriority, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
        return self.constraint(greaterThanOrEqualTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier, priority: priority)
    }
    
    public func constraint(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, _ priority: LayoutPriority, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
        return self.constraint(lessThanOrEqualTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier, priority: priority)
    }
}

extension NSLayoutYAxisAnchor: LayoutAnchorSingle {
    public func constraint(equalTo anchor: NSLayoutYAxisAnchor, _ priority: LayoutPriority, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
        return self.constraint(equalTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier, priority: priority)
    }
    
    public func constraint(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, _ priority: LayoutPriority, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
        return self.constraint(greaterThanOrEqualTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier, priority: priority)
    }
    
    public func constraint(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, _ priority: LayoutPriority, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
        return self.constraint(lessThanOrEqualTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier, priority: priority)
    }
}

// MARK: - Two Anchors

/// A layout anchor representing the width and height of the object generating this instance.
public struct LayoutSizeAnchor: LayoutAnchorPair {
    public typealias Constant = CGSize
    public typealias Constraint = NSLayoutConstraint.Size
    /// The actual width and height anchors.
    public let widthAnchor: NSLayoutDimension, heightAnchor: NSLayoutDimension
    
    init(_ anchorA: NSLayoutDimension, _ anchorB: NSLayoutDimension) {
        (self.widthAnchor, self.heightAnchor) = (anchorA, anchorB)
    }
    
    var all: (NSLayoutDimension, NSLayoutDimension) {
        return (self.widthAnchor, self.heightAnchor)
    }
}

extension LayoutSizeAnchor: LayoutAnchorSimple {
    public func constraint(equalTo constant: CGSize, priority: LayoutPriority) -> NSLayoutConstraint.Size {
        return .init(width: self.widthAnchor.constraint(equalTo: constant.width, priority: priority),
                     height: self.heightAnchor.constraint(equalTo: constant.height, priority: priority))
    }
    
    public func constraint(greaterThanOrEqualTo constant: CGSize, priority: LayoutPriority) -> NSLayoutConstraint.Size {
        return .init(width: self.widthAnchor.constraint(greaterThanOrEqualTo: constant.width, priority: priority),
                     height: self.heightAnchor.constraint(greaterThanOrEqualTo: constant.height, priority: priority))
    }
    
    public func constraint(lessThanOrEqualTo constant: CGSize, priority: LayoutPriority) -> NSLayoutConstraint.Size {
        return .init(width: self.widthAnchor.constraint(lessThanOrEqualTo: constant.width, priority: priority),
                     height: self.heightAnchor.constraint(lessThanOrEqualTo: constant.height, priority: priority))
    }
}

/// A layout anchor representing the X and Y center coordinates of the object generating this instance.
public struct LayoutCenterCenterAnchor: LayoutAnchorPair {
    public typealias Constant = CGPoint
    public typealias Constraint = NSLayoutConstraint.Center
    /// The actual center X and Y coordinates.
    public let x: NSLayoutXAxisAnchor, y: NSLayoutYAxisAnchor
    
    init(_ anchorA: NSLayoutXAxisAnchor, _ anchorB: NSLayoutYAxisAnchor) {
        (self.x, self.y) = (anchorA, anchorB)
    }
    
    var all: (NSLayoutXAxisAnchor, NSLayoutYAxisAnchor) {
        return (self.x, self.y)
    }
}

/// A layout anchor representing the top and bottom boundaries of the object generating this instance.
public struct LayoutVerticalAnchor: LayoutAnchorPair {
    public typealias Constant = VerticalInsets
    public typealias Constraint = NSLayoutConstraint.Vertical
    /// The actual top and bottom boundary anchors.
    public let top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor
    
    internal init(_ anchorA: NSLayoutYAxisAnchor, _ anchorB: NSLayoutYAxisAnchor) {
        (self.top, self.bottom) = (anchorA, anchorB)
    }
    
    var all: (NSLayoutYAxisAnchor, NSLayoutYAxisAnchor) {
        return (self.top, self.bottom)
    }
}

/// A layout anchor representing the left and right boundaries of the object generating this instance.
public struct LayoutHorizontalAnchor: LayoutAnchorPair {
    public typealias Constant = HorizontalInsets
    public typealias Constraint = NSLayoutConstraint.Horizontal
    /// The actual left and right boundary anchors.
    let left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor
    
    init(_ anchorA: NSLayoutXAxisAnchor, _ anchorB: NSLayoutXAxisAnchor) {
        (self.left, self.right) = (anchorA, anchorB)
    }
    
    var all: (NSLayoutXAxisAnchor, NSLayoutXAxisAnchor) {
        return (self.left, self.right)
    }
}

/// A layout anchor representing the leading and trailing boundaries of the object generating this instance.
public struct LayoutDirectionalAnchor: LayoutAnchorPair {
    public typealias Constant = DirectionalInsets
    public typealias Constraint = NSLayoutConstraint.Directional
    
    let leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor
    
    init(_ anchorA: NSLayoutXAxisAnchor, _ anchorB: NSLayoutXAxisAnchor) {
        (self.leading, self.trailing) = (anchorA, anchorB)
    }
    
    var all: (NSLayoutXAxisAnchor, NSLayoutXAxisAnchor) {
        return (self.leading, self.trailing)
    }
}

// MARK: - Four Anchors

public struct LayoutEdgeAnchor: LayoutAnchorQuartet {
    public typealias Constant = EdgeInsets
    public typealias Constraint = NSLayoutConstraint.Edges
    
    let top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor
    let left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor
    
    init(_ anchorA: NSLayoutYAxisAnchor, _ anchorB: NSLayoutXAxisAnchor, _ anchorC: NSLayoutYAxisAnchor, _ anchorD: NSLayoutXAxisAnchor) {
        (self.top, self.bottom) = (anchorA, anchorC)
        (self.left, self.right) = (anchorB, anchorD)
    }
    
    var all: (NSLayoutYAxisAnchor, NSLayoutXAxisAnchor, NSLayoutYAxisAnchor, NSLayoutXAxisAnchor) {
        return (self.top, self.left, self.bottom, self.right)
    }
}

public struct LayoutDirectionalEdgeAnchor: LayoutAnchorQuartet {
    public typealias Constant = DirectionalEdgeInsets
    public typealias Constraint = NSLayoutConstraint.DirectionalEdges
    
    let top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor
    let leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor
    
    init(_ anchorA: NSLayoutYAxisAnchor, _ anchorB: NSLayoutXAxisAnchor, _ anchorC: NSLayoutYAxisAnchor, _ anchorD: NSLayoutXAxisAnchor) {
        (self.top, self.bottom) = (anchorA, anchorC)
        (self.leading, self.trailing) = (anchorB, anchorD)
    }
    
    var all: (NSLayoutYAxisAnchor, NSLayoutXAxisAnchor, NSLayoutYAxisAnchor, NSLayoutXAxisAnchor) {
        return (self.top, self.leading, self.bottom, self.trailing)
    }
}
