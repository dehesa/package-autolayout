#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#else
#error("OS not supported")
#endif

// MARK: Single Constraint

extension NSLayoutConstraint: LayoutConstraint {
    public typealias Constant = CGFloat
    public typealias Identifier = String?
    public typealias Activity = Bool
    /// If a multiplier is given, the receiving constraint is duplicated modifying its multiplier property.
    /// - parameter multiplier: Optional multiplier to to use in the constraint formula.
    /// - returns: The receiving constraint (if duplication wasn't needed) or a newly created constraint with the basic attributes copied (NOT all attributes are copied).
    internal func basicDuplicationIfNeeded(withMultiplier multiplier: CGFloat?) -> NSLayoutConstraint {
        let result: NSLayoutConstraint
        if let multiplier = multiplier {
            result = NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
        } else {
            result = self
        }
        return result
    }
}

// MARK: - Two Constraints

extension NSLayoutConstraint {
    /// Constraints group defining the width and height of an object.
    ///
    /// This is basically a container for the witdth and height dimensional constraints.
    public struct Size: LayoutConstraintGroup {
        public typealias Constant = CGSize
        public typealias Identifier = (String?, String?)
        public typealias Activity = (Bool, Bool)
        public typealias Priority = (LayoutPriority, LayoutPriority)
        
        /// The width dimensional constraint.
        public var width: NSLayoutConstraint
        /// The height dimensional constraint.
        public var height: NSLayoutConstraint
        
        /// Designated initializer passing the width and height dimensional constraints.
        public init(width: NSLayoutConstraint, height: NSLayoutConstraint) {
            (self.width, self.height) = (width, height)
        }
        
        public init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
            var iterator = sequence.makeIterator()
            guard let width = iterator.next(),
                  let height = iterator.next() else { return nil }
            self.init(width: width, height: height)
        }
        
        public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
            return .init(self.width, self.height)
        }
    }
    
    /// Constraint group defining the center X and Y of an object.
    ///
    /// This is basically a container for the center X and Y constraints.
    public struct Center: LayoutConstraintGroup {
        public typealias Constant = CGPoint
        public typealias Identifier = (String?, String?)
        public typealias Activity = (Bool, Bool)
        public typealias Priority = (LayoutPriority, LayoutPriority)
        
        /// The center X constraint.
        public var x: NSLayoutConstraint
        /// The center Y constraint.
        public var y: NSLayoutConstraint
        
        /// Designated initializer passing the center X and Y constraints.
        public init(x: NSLayoutConstraint, y: NSLayoutConstraint) {
            (self.x, self.y) = (x, y)
        }
        
        public init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
            var iterator = sequence.makeIterator()
            guard let x = iterator.next(),
                  let y = iterator.next() else { return nil }
            self.init(x: x, y: y)
        }
        
        public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
            return .init(self.x, self.y)
        }
    }
    
    /// Constraint group defining the top and bottom vertical constraints of an object.
    public struct Vertical: LayoutConstraintGroup {
        public typealias Constant = VerticalInsets
        public typealias Identifier = (String?, String?)
        public typealias Activity = (Bool, Bool)
        public typealias Priority = (LayoutPriority, LayoutPriority)
        
        /// The top constraint.
        public var top: NSLayoutConstraint
        /// The bottom constraint.
        public var bottom: NSLayoutConstraint
        
        /// Designated initializer passing the top and bottom constraints.
        public init(top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
            (self.top, self.bottom) = (top, bottom)
        }
        
        public init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
            var iterator = sequence.makeIterator()
            guard let top = iterator.next(), let bottom = iterator.next() else { return nil }
            self.init(top: top, bottom: bottom)
        }
        
        public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
            return .init(self.top, self.bottom)
        }
    }
    
    /// Constraint group defining the left and right constraints of an object.
    public struct Horizontal: LayoutConstraintGroup {
        public typealias Constant = HorizontalInsets
        public typealias Identifier = (String?, String?)
        public typealias Activity = (Bool, Bool)
        public typealias Priority = (LayoutPriority, LayoutPriority)
        
        /// The left constraint.
        public var left: NSLayoutConstraint
        /// The right constraint.
        public var right: NSLayoutConstraint
        
        /// Designated initializer passing the left and right constraints.
        public init(left: NSLayoutConstraint, right: NSLayoutConstraint) {
            (self.left, self.right) = (left, right)
        }
        
        public init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
            var iterator = sequence.makeIterator()
            guard let left = iterator.next(),
                  let right = iterator.next() else { return nil }
            self.init(left: left, right: right)
        }
        
        public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
            return .init(self.left, self.right)
        }
    }
    
    /// Constraint group defining the leading and trailing constraints of an object.
    public struct Directional: LayoutConstraintGroup {
        public typealias Constant = DirectionalInsets
        public typealias Identifier = (String?, String?)
        public typealias Activity = (Bool, Bool)
        public typealias Priority = (LayoutPriority, LayoutPriority)
        
        /// The leading constraint.
        public var leading: NSLayoutConstraint
        /// The trailing constraint.
        public var trailing: NSLayoutConstraint
        
        /// Designated initializer passing the leading and trailing constraints.
        public init(leading: NSLayoutConstraint, trailing: NSLayoutConstraint) {
            (self.leading, self.trailing) = (leading, trailing)
        }
        
        public init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
            var iterator = sequence.makeIterator()
            guard let leading = iterator.next(),
                  let trailing = iterator.next() else { return nil }
            self.init(leading: leading, trailing: trailing)
        }
        
        public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
            return .init(self.leading, self.trailing)
        }
    }
}

// MARK: - Four Constraints

extension NSLayoutConstraint {
    /// Constraint group defining the top, left, bottom, right constraint of an object.
    public struct Edges: LayoutConstraintGroup {
        public typealias Constant = EdgeInsets
        public typealias Identifier = (String?, String?, String?, String?)
        public typealias Activity = (Bool, Bool, Bool, Bool)
        public typealias Priority = (LayoutPriority, LayoutPriority, LayoutPriority, LayoutPriority)
        
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
        
        public init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
            var iterator = sequence.makeIterator()
            guard let top = iterator.next(),
                  let left = iterator.next(),
                  let bottom = iterator.next(),
                  let right = iterator.next() else { return nil }
            self.init(top: top, left: left, bottom: bottom, right: right)
        }
        
        public func makeIterator() -> LayoutIteratorQuartet<NSLayoutConstraint> {
            return .init(self.top, self.left, self.bottom, self.right)
        }
    }
    
    /// Constraint group defining the top, leading, bottom, right constraints of an object.
    public struct DirectionalEdges: LayoutConstraintGroup {
        public typealias Constant = DirectionalEdgeInsets
        public typealias Identifier = (String?, String?, String?, String?)
        public typealias Activity = (Bool, Bool, Bool, Bool)
        public typealias Priority = (LayoutPriority, LayoutPriority, LayoutPriority, LayoutPriority)
        
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
        
        public init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
            var iterator = sequence.makeIterator()
            guard let top = iterator.next(),
                  let leading = iterator.next(),
                  let bottom = iterator.next(),
                  let trailing = iterator.next() else { return nil }
            self.init(top: top, leading: leading, bottom: bottom, trailing: trailing)
        }
        
        public func makeIterator() -> LayoutIteratorQuartet<NSLayoutConstraint> {
            return .init(self.top, self.leading, self.bottom, self.trailing)
        }
    }
}
