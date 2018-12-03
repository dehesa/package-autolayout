#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

// MARK: - Protocols

/// Concrete types conforming to this protocol represent a layout anchor used in Autolayout.
public protocol Anchor {
    /// The type of constant associated with the given layout anchor.
    associatedtype Constant: AnchorConstant
}

///
public protocol SingleAnchor: Anchor {
    ///
    func constraint(equalTo anchor: Self, multiplier: CGFloat, constant: Self.Constant, priority: Priority) -> NSLayoutConstraint
    ///
    func constraint(greaterThan anchor: Self, multiplier: CGFloat, constant: Self.Constant, priority: Priority) -> NSLayoutConstraint
    ///
    func constraint(lessThan anchor: Self, multiplier: CGFloat, constant: Self.Constant, priority: Priority) -> NSLayoutConstraint
}

///
public protocol AggregateAnchor: Anchor {
    
}

// MARK: - Types

extension NSLayoutDimension: SingleAnchor {
    public typealias Constant = CGFloat
    
    public func constraint(equalTo anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat, priority: Priority) -> NSLayoutConstraint {
        let result = self.constraint(equalTo: anchor, multiplier: multiplier, constant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(greaterThan anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat, priority: Priority) -> NSLayoutConstraint {
        let result = self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(lessThan anchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat, priority: Priority) -> NSLayoutConstraint {
        let result = self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
        result.priority = priority
        return result
    }
}

extension NSLayoutXAxisAnchor: SingleAnchor {
    public typealias Constant = CGFloat
    
    public func constraint(equalTo anchor: NSLayoutXAxisAnchor, multiplier: CGFloat, constant: CGFloat, priority: Priority) -> NSLayoutConstraint {
        let i = self.constraint(equalTo: anchor)
        let result = NSLayoutConstraint(item: i.firstItem!, attribute: i.firstAttribute, relatedBy: i.relation, toItem: i.secondItem, attribute: i.secondAttribute, multiplier: multiplier, constant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(greaterThan anchor: NSLayoutXAxisAnchor, multiplier: CGFloat, constant: CGFloat, priority: Priority) -> NSLayoutConstraint {
        let i = self.constraint(greaterThanOrEqualTo: anchor)
        let result = NSLayoutConstraint(item: i.firstItem!, attribute: i.firstAttribute, relatedBy: i.relation, toItem: i.secondItem, attribute: i.secondAttribute, multiplier: multiplier, constant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(lessThan anchor: NSLayoutXAxisAnchor, multiplier: CGFloat, constant: CGFloat, priority: Priority) -> NSLayoutConstraint {
        let i = self.constraint(lessThanOrEqualTo: anchor)
        let result = NSLayoutConstraint(item: i.firstItem!, attribute: i.firstAttribute, relatedBy: i.relation, toItem: i.secondItem, attribute: i.secondAttribute, multiplier: multiplier, constant: constant)
        result.priority = priority
        return result
    }
}

extension NSLayoutYAxisAnchor: SingleAnchor {
    public typealias Constant = CGFloat
    
    public func constraint(equalTo anchor: NSLayoutYAxisAnchor, multiplier: CGFloat, constant: CGFloat, priority: Priority) -> NSLayoutConstraint {
        let i = self.constraint(equalTo: anchor, constant: constant)
        let result = NSLayoutConstraint(item: i.firstItem!, attribute: i.firstAttribute, relatedBy: i.relation, toItem: i.secondItem, attribute: i.secondAttribute, multiplier: multiplier, constant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(greaterThan anchor: NSLayoutYAxisAnchor, multiplier: CGFloat, constant: CGFloat, priority: Priority) -> NSLayoutConstraint {
        let i = self.constraint(greaterThanOrEqualTo: anchor)
        let result = NSLayoutConstraint(item: i.firstItem!, attribute: i.firstAttribute, relatedBy: i.relation, toItem: i.secondItem, attribute: i.secondAttribute, multiplier: multiplier, constant: constant)
        result.priority = priority
        return result
    }
    
    public func constraint(lessThan anchor: NSLayoutYAxisAnchor, multiplier: CGFloat, constant: CGFloat, priority: Priority) -> NSLayoutConstraint {
        let i = self.constraint(lessThanOrEqualTo: anchor)
        let result = NSLayoutConstraint(item: i.firstItem!, attribute: i.firstAttribute, relatedBy: i.relation, toItem: i.secondItem, attribute: i.secondAttribute, multiplier: multiplier, constant: constant)
        result.priority = priority
        return result
    }
}

public struct CenterAnchor: AggregateAnchor {
    public typealias Constant = CGPoint
    
    let x: NSLayoutXAxisAnchor, y: NSLayoutYAxisAnchor
    
    init(x: NSLayoutXAxisAnchor, y: NSLayoutYAxisAnchor) {
        (self.x, self.y) = (x, y)
    }
}

public struct SizeAnchor: AggregateAnchor {
    public typealias Constant = CGSize
    
    let widthAnchor: NSLayoutDimension, heightAnchor: NSLayoutDimension
    
    init(width: NSLayoutDimension, height: NSLayoutDimension) {
        (self.widthAnchor, self.heightAnchor) = (width, height)
    }
}

public struct VerticalAnchor: AggregateAnchor {
    public typealias Constant = VerticalInsets
    
    let top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor
    
    init(top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor) {
        (self.top, self.bottom) = (top, bottom)
    }
}

public struct HorizontalAnchor: AggregateAnchor {
    public typealias Constant = HorizontalInsets
    
    let left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor
    
    init(left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) {
        (self.left, self.right) = (left, right)
    }
}

public struct DirectionalAnchor: AggregateAnchor {
    public typealias Constant = DirectionalInsets
    
    let leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor
    
    init(leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor) {
        (self.leading, self.trailing) = (leading, trailing)
    }
}

public struct EdgeAnchor: AggregateAnchor {
    public typealias Constant = EdgeInsets
    
    let top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor
    let left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor
    
    init(top: NSLayoutYAxisAnchor, left: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, right: NSLayoutXAxisAnchor) {
        (self.top, self.bottom) = (top, bottom)
        (self.left, self.right) = (left, right)
    }
}

public struct DirectionalEdgeAnchor: AggregateAnchor {
    public typealias Constant = DirectionalEdgeInsets
    
    let top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor
    let leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor
    
    init(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor) {
        (self.top, self.bottom) = (top, bottom)
        (self.leading, self.trailing) = (leading, trailing)
    }
}
