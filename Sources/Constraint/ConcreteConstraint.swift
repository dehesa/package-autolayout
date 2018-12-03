#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

// MARK: Single Constraint

extension NSLayoutConstraint: LayoutConstraint {
    public typealias Identifier = String
    
    public func activating(_ isActive: Bool) -> Self {
        self.isActive = isActive
        return self
    }
    
    public func identifying(_ identifier: String) -> Self {
        self.identifier = identifier
        return self
    }
    
    /// Duplicates a constraint and modifies its multiplier and priority properties with the ones passed as arguments.
    internal func duplicate(withMultiplier multiplier: CGFloat?, priority: LayoutPriority) -> NSLayoutConstraint {
        let result: NSLayoutConstraint
        if let multiplier = multiplier {
            result = NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
        } else {
            result = self
        }
        result.priority = priority
        return result
    }
}

// MARK: - Two Constraints

extension NSLayoutConstraint {
    /// Constraints defining width and height of an object.
    public final class Size: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Constraints = (NSLayoutConstraint, NSLayoutConstraint)
        
        public var width: NSLayoutConstraint, height: NSLayoutConstraint
        
        public init(width: NSLayoutConstraint, height: NSLayoutConstraint) {
            (self.width, self.height) = (width, height)
        }
        
        public static func make(with constraints: Constraints) -> NSLayoutConstraint.Size {
            return .init(width: constraints.0, height: constraints.1)
        }
        
        public var all: Constraints {
            return (self.width, self.height)
        }
    }
    
    public final class Center: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Constraints = (NSLayoutConstraint, NSLayoutConstraint)
        
        public var x: NSLayoutConstraint, y: NSLayoutConstraint
        
        public init(x: NSLayoutConstraint, y: NSLayoutConstraint) {
            (self.x, self.y) = (x, y)
        }
        
        public static func make(with constraints: Constraints) -> NSLayoutConstraint.Center {
            return .init(x: constraints.0, y: constraints.1)
        }
        
        public var all: Constraints {
            return (self.x, self.y)
        }
    }
    
    public final class Vertical: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Constraints = (NSLayoutConstraint, NSLayoutConstraint)
        
        public var top: NSLayoutConstraint, bottom: NSLayoutConstraint
        
        public init(top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
            (self.top, self.bottom) = (top, bottom)
        }
        
        public static func make(with constraints: Constraints) -> NSLayoutConstraint.Vertical {
            return .init(top: constraints.0, bottom: constraints.1)
        }
        
        public var all: Constraints {
            return (self.top, self.bottom)
        }
    }
    
    public final class Horizontal: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Constraints = (NSLayoutConstraint, NSLayoutConstraint)
        
        public var left: NSLayoutConstraint, right: NSLayoutConstraint
        
        public init(left: NSLayoutConstraint, right: NSLayoutConstraint) {
            (self.left, self.right) = (left, right)
        }
        
        public static func make(with constraints: Constraints) -> NSLayoutConstraint.Horizontal {
            return .init(left: constraints.0, right: constraints.1)
        }
        
        public var all: Constraints {
            return (self.left, self.right)
        }
    }
    
    public final class Directional: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Constraints = (NSLayoutConstraint, NSLayoutConstraint)
        
        public var leading: NSLayoutConstraint, trailing: NSLayoutConstraint
        
        public init(leading: NSLayoutConstraint, trailing: NSLayoutConstraint) {
            (self.leading, self.trailing) = (leading, trailing)
        }
        
        public static func make(with constraints: Constraints) -> NSLayoutConstraint.Directional {
            return .init(leading: constraints.0, trailing: constraints.1)
        }
        
        public var all: Constraints {
            return (self.leading, self.trailing)
        }
    }
}

// MARK: - Four Constraints

extension NSLayoutConstraint {
    public final class Edges: LayoutConstraintGroup {
        public typealias Identifier = (String, String, String, String)
        public typealias Constraints = (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint)
        
        public var top: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint, right: NSLayoutConstraint
        
        public init(top: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint, right: NSLayoutConstraint) {
            (self.top, self.bottom) = (top, bottom)
            (self.left, self.right) = (left, right)
        }
        
        public static func make(with constraints: Constraints) -> NSLayoutConstraint.Edges {
            return .init(top: constraints.0, left: constraints.1, bottom: constraints.2, right: constraints.3)
        }
        
        public var all: Constraints {
            return (self.top, self.left, self.bottom, self.right)
        }
    }
    
    public final class DirectionalEdges: LayoutConstraintGroup {
        public typealias Identifier = (String, String, String, String)
        public typealias Constraints = (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint)
        
        public var top: NSLayoutConstraint, leading: NSLayoutConstraint, bottom: NSLayoutConstraint, trailing: NSLayoutConstraint
        
        public init(top: NSLayoutConstraint, leading: NSLayoutConstraint, bottom: NSLayoutConstraint, trailing: NSLayoutConstraint) {
            (self.top, self.bottom) = (top, bottom)
            (self.leading, self.trailing) = (leading, trailing)
        }
        
        public static func make(with constraints: Constraints) -> NSLayoutConstraint.DirectionalEdges {
            return .init(top: constraints.0, leading: constraints.1, bottom: constraints.2, trailing: constraints.3)
        }
        
        public var all: Constraints {
            return (self.top, self.leading, self.bottom, self.trailing)
        }
    }
}

