#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
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
    
    public func prioritizing(_ priority: LayoutPriority) -> Self {
        self.priority = priority
        return self
    }
    
    /// Duplicates a constraint and modifies its multiplier and priority properties with the ones passed as arguments.
    /// - parameter multiplier: Optional multiplier to to use in the constraint formula.
    /// - parameter priority: The layout priority that the result constraint will have.
    /// - returns: The receiving constraint (if duplication wasn't needed) or a newly created constraint with the basic attributes copied (not all attributes are copied).
    internal func basicDuplicationIfNeeded(withMultiplier multiplier: CGFloat?, priority: LayoutPriority) -> NSLayoutConstraint {
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
    /// Constraints group defining the width and height of an object.
    ///
    /// This is basically a container for the witdth and height dimensional constraints.
    public final class Size: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Members = (NSLayoutConstraint, NSLayoutConstraint)
        /// The width dimensional constraint.
        public var width: NSLayoutConstraint
        /// The height dimensional constraint.
        public var height: NSLayoutConstraint
        /// Designated initializer passing the width and height dimensional constraints.
        public init(width: NSLayoutConstraint, height: NSLayoutConstraint) {
            (self.width, self.height) = (width, height)
        }
        
        public static func make(with members: Members) -> NSLayoutConstraint.Size {
            return .init(width: members.0, height: members.1)
        }
        
        public var all: Members {
            return (self.width, self.height)
        }
    }
    
    /// Constraint group defining the center X and Y of an object.
    ///
    /// This is basically a container for the center X and Y constraints.
    public final class Center: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Members = (NSLayoutConstraint, NSLayoutConstraint)
        /// The center X constraint.
        public var x: NSLayoutConstraint
        /// The center Y constraint.
        public var y: NSLayoutConstraint
        /// Designated initializer passing the center X and Y constraints.
        public init(x: NSLayoutConstraint, y: NSLayoutConstraint) {
            (self.x, self.y) = (x, y)
        }
        
        public static func make(with members: Members) -> NSLayoutConstraint.Center {
            return .init(x: members.0, y: members.1)
        }
        
        public var all: Members {
            return (self.x, self.y)
        }
    }
    
    /// Constraint group defining the top and bottom vertical constraints of an object.
    public final class Vertical: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Members = (NSLayoutConstraint, NSLayoutConstraint)
        /// The top constraint.
        public var top: NSLayoutConstraint
        /// The bottom constraint.
        public var bottom: NSLayoutConstraint
        /// Designated initializer passing the top and bottom constraints.
        public init(top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
            (self.top, self.bottom) = (top, bottom)
        }
        
        public static func make(with constraints: Members) -> NSLayoutConstraint.Vertical {
            return .init(top: constraints.0, bottom: constraints.1)
        }
        
        public var all: Members {
            return (self.top, self.bottom)
        }
    }
    
    /// Constraint group defining the left and right constraints of an object.
    public final class Horizontal: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Members = (NSLayoutConstraint, NSLayoutConstraint)
        /// The left constraint.
        public var left: NSLayoutConstraint
        /// The right constraint.
        public var right: NSLayoutConstraint
        /// Designated initializer passing the left and right constraints.
        public init(left: NSLayoutConstraint, right: NSLayoutConstraint) {
            (self.left, self.right) = (left, right)
        }
        
        public static func make(with constraints: Members) -> NSLayoutConstraint.Horizontal {
            return .init(left: constraints.0, right: constraints.1)
        }
        
        public var all: Members {
            return (self.left, self.right)
        }
    }
    
    /// Constraint group defining the leading and trailing constraints of an object.
    public final class Directional: LayoutConstraintGroup {
        public typealias Identifier = (String, String)
        public typealias Members = (NSLayoutConstraint, NSLayoutConstraint)
        /// The leading constraint.
        public var leading: NSLayoutConstraint
        /// The trailing constraint.
        public var trailing: NSLayoutConstraint
        /// Designated initializer passing the leading and trailing constraints.
        public init(leading: NSLayoutConstraint, trailing: NSLayoutConstraint) {
            (self.leading, self.trailing) = (leading, trailing)
        }
        
        public static func make(with constraints: Members) -> NSLayoutConstraint.Directional {
            return .init(leading: constraints.0, trailing: constraints.1)
        }
        
        public var all: Members {
            return (self.leading, self.trailing)
        }
    }
}

// MARK: - Four Constraints

extension NSLayoutConstraint {
    /// Constraint group defining the top, left, bottom, right constraint of an object.
    public final class Edges: LayoutConstraintGroup {
        public typealias Identifier = (String, String, String, String)
        public typealias Members = (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint)
        /// The top constraint.
        public var top: NSLayoutConstraint
        /// The left constraint.
        public var left: NSLayoutConstraint
        /// The bottom constraint.
        public var bottom: NSLayoutConstraint
        /// The right constraint.
        public var right: NSLayoutConstraint
        /// Designated initializer passing the top, left, bottom, right constraints.
        public init(top: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint, right: NSLayoutConstraint) {
            (self.top, self.bottom) = (top, bottom)
            (self.left, self.right) = (left, right)
        }
        
        public static func make(with constraints: Members) -> NSLayoutConstraint.Edges {
            return .init(top: constraints.0, left: constraints.1, bottom: constraints.2, right: constraints.3)
        }
        
        public var all: Members {
            return (self.top, self.left, self.bottom, self.right)
        }
    }
    
    /// Constraint group defining the top, leading, bottom, right constraints of an object.
    public final class DirectionalEdges: LayoutConstraintGroup {
        public typealias Identifier = (String, String, String, String)
        public typealias Members = (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint)
        /// The top constraint.
        public var top: NSLayoutConstraint
        /// The leading constraint.
        public var leading: NSLayoutConstraint
        /// The bottom constraint.
        public var bottom: NSLayoutConstraint
        /// The trailing constraint.
        public var trailing: NSLayoutConstraint
        
        public init(top: NSLayoutConstraint, leading: NSLayoutConstraint, bottom: NSLayoutConstraint, trailing: NSLayoutConstraint) {
            (self.top, self.bottom) = (top, bottom)
            (self.leading, self.trailing) = (leading, trailing)
        }
        
        public static func make(with constraints: Members) -> NSLayoutConstraint.DirectionalEdges {
            return .init(top: constraints.0, leading: constraints.1, bottom: constraints.2, trailing: constraints.3)
        }
        
        public var all: Members {
            return (self.top, self.leading, self.bottom, self.trailing)
        }
    }
}
