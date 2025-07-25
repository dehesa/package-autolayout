#if canImport(AppKit)
public import AppKit
#elseif canImport(UIKit)
public import UIKit
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
  @usableFromInline func basicDuplicationIfNeeded(withMultiplier multiplier: CGFloat?) -> NSLayoutConstraint {
    guard let m = multiplier else { return self }
    return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: m, constant: self.constant)
  }
}

// MARK: - Two Constraints

extension NSLayoutConstraint {
  /// Constraints group defining the width and height of an object.
  ///
  /// This is basically a container for the witdth and height dimensional constraints.
  public final class Size: LayoutConstraintGroup {
    public typealias Constant = CGSize
    public typealias Identifier = (String?, String?)
    public typealias Activity = (Bool, Bool)
    public typealias Priority = (LayoutPriority, LayoutPriority)

    /// The width dimensional constraint.
    public let width: NSLayoutConstraint
    /// The height dimensional constraint.
    public let height: NSLayoutConstraint

    /// Designated initializer passing the width and height dimensional constraints.
    public init(width: NSLayoutConstraint, height: NSLayoutConstraint) {
      (self.width, self.height) = (width, height)
    }

    @inlinable public convenience init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
      var iterator = sequence.makeIterator()
      guard let width = iterator.next(), let height = iterator.next() else { return nil }
      self.init(width: width, height: height)
    }

    @inlinable public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
      LayoutIteratorPair(self.width, self.height)
    }

    public static var defaultSuffixes: Identifier {
      (".width", ".height")
    }
  }

  /// Constraint group defining the center X and Y of an object.
  ///
  /// This is basically a container for the center X and Y constraints.
  public final class Center: LayoutConstraintGroup {
    public typealias Constant = CGPoint
    public typealias Identifier = (String?, String?)
    public typealias Activity = (Bool, Bool)
    public typealias Priority = (LayoutPriority, LayoutPriority)

    /// The center X constraint.
    public let x: NSLayoutConstraint
    /// The center Y constraint.
    public let y: NSLayoutConstraint

    /// Designated initializer passing the center X and Y constraints.
    public init(x: NSLayoutConstraint, y: NSLayoutConstraint) {
      (self.x, self.y) = (x, y)
    }

    @inlinable public convenience init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
      var iterator = sequence.makeIterator()
      guard let x = iterator.next(), let y = iterator.next() else { return nil }
      self.init(x: x, y: y)
    }

    @inlinable public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
      LayoutIteratorPair(self.x, self.y)
    }

    public static var defaultSuffixes: Identifier {
      (".x", ".y")
    }
  }

  /// Constraint group defining the top and bottom vertical constraints of an object.
  public final class Vertical: LayoutConstraintGroup {
    public typealias Constant = VerticalInsets
    public typealias Identifier = (String?, String?)
    public typealias Activity = (Bool, Bool)
    public typealias Priority = (LayoutPriority, LayoutPriority)

    /// The top constraint.
    public let top: NSLayoutConstraint
    /// The bottom constraint.
    public let bottom: NSLayoutConstraint

    /// Designated initializer passing the top and bottom constraints.
    public init(top: NSLayoutConstraint, bottom: NSLayoutConstraint) {
      (self.top, self.bottom) = (top, bottom)
    }

    @inlinable public convenience init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
      var iterator = sequence.makeIterator()
      guard let top = iterator.next(), let bottom = iterator.next() else { return nil }
      self.init(top: top, bottom: bottom)
    }

    @inlinable public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
      LayoutIteratorPair(self.top, self.bottom)
    }

    public static var defaultSuffixes: Identifier {
      (".top", ".bottom")
    }
  }

  /// Constraint group defining the left and right constraints of an object.
  public final class Horizontal: LayoutConstraintGroup {
    public typealias Constant = HorizontalInsets
    public typealias Identifier = (String?, String?)
    public typealias Activity = (Bool, Bool)
    public typealias Priority = (LayoutPriority, LayoutPriority)

    /// The left constraint.
    public let left: NSLayoutConstraint
    /// The right constraint.
    public let right: NSLayoutConstraint

    /// Designated initializer passing the left and right constraints.
    public init(left: NSLayoutConstraint, right: NSLayoutConstraint) {
      (self.left, self.right) = (left, right)
    }

    @inlinable public convenience init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
      var iterator = sequence.makeIterator()
      guard let left = iterator.next(), let right = iterator.next() else { return nil }
      self.init(left: left, right: right)
    }

    @inlinable public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
      LayoutIteratorPair(self.left, self.right)
    }

    public static var defaultSuffixes: Identifier {
      (".left", ".right")
    }
  }

  /// Constraint group defining the leading and trailing constraints of an object.
  public final class Directional: LayoutConstraintGroup {
    public typealias Constant = DirectionalInsets
    public typealias Identifier = (String?, String?)
    public typealias Activity = (Bool, Bool)
    public typealias Priority = (LayoutPriority, LayoutPriority)

    /// The leading constraint.
    public let leading: NSLayoutConstraint
    /// The trailing constraint.
    public let trailing: NSLayoutConstraint

    /// Designated initializer passing the leading and trailing constraints.
    public init(leading: NSLayoutConstraint, trailing: NSLayoutConstraint) {
      (self.leading, self.trailing) = (leading, trailing)
    }

    @inlinable public convenience init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
      var iterator = sequence.makeIterator()
      guard let leading = iterator.next(), let trailing = iterator.next() else { return nil }
      self.init(leading: leading, trailing: trailing)
    }

    @inlinable public func makeIterator() -> LayoutIteratorPair<NSLayoutConstraint> {
      LayoutIteratorPair(self.leading, self.trailing)
    }

    public static var defaultSuffixes: Identifier {
      (".leading", ".trailing")
    }
  }
}

// MARK: - Four Constraints

extension NSLayoutConstraint {
  /// Constraint group defining the top, left, bottom, right constraint of an object.
  public final class Edges: LayoutConstraintGroup {
    public typealias Constant = EdgeInsets
    public typealias Identifier = (String?, String?, String?, String?)
    public typealias Activity = (Bool, Bool, Bool, Bool)
    public typealias Priority = (LayoutPriority, LayoutPriority, LayoutPriority, LayoutPriority)

    /// The top constraint.
    public let top: NSLayoutConstraint
    /// The left constraint.
    public let left: NSLayoutConstraint
    /// The bottom constraint.
    public let bottom: NSLayoutConstraint
    /// The right constraint.
    public let right: NSLayoutConstraint

    /// Designated initializer passing the top, left, bottom, right constraints.
    public init(top: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint, right: NSLayoutConstraint) {
      (self.top, self.bottom) = (top, bottom)
      (self.left, self.right) = (left, right)
    }

    /// Convenience initializer where the single constraint will be extracted.
    public convenience init(vertical: NSLayoutConstraint.Vertical, horizontal: NSLayoutConstraint.Horizontal) {
      self.init(top: vertical.top, left: horizontal.left, bottom: vertical.bottom, right: horizontal.right)
    }

    @inlinable public convenience init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
      var iterator = sequence.makeIterator()
      guard let top = iterator.next(), let left = iterator.next(),
            let bottom = iterator.next(), let right = iterator.next() else { return nil }
      self.init(top: top, left: left, bottom: bottom, right: right)
    }

    @inlinable public func makeIterator() -> LayoutIteratorQuartet<NSLayoutConstraint> {
      LayoutIteratorQuartet(self.top, self.left, self.bottom, self.right)
    }

    public static var defaultSuffixes: Identifier {
      (".top", ".left", ".bottom", ".right")
    }
  }
}

extension NSLayoutConstraint {
  /// Constraint group defining the top, leading, bottom, right constraints of an object.
  public final class DirectionalEdges: LayoutConstraintGroup {
    public typealias Constant = DirectionalEdgeInsets
    public typealias Identifier = (String?, String?, String?, String?)
    public typealias Activity = (Bool, Bool, Bool, Bool)
    public typealias Priority = (LayoutPriority, LayoutPriority, LayoutPriority, LayoutPriority)

    /// The top constraint.
    public let top: NSLayoutConstraint
    /// The leading constraint.
    public let leading: NSLayoutConstraint
    /// The bottom constraint.
    public let bottom: NSLayoutConstraint
    /// The trailing constraint.
    public let trailing: NSLayoutConstraint

    /// Designated initializer specifying every single constraint.
    public init(top: NSLayoutConstraint, leading: NSLayoutConstraint, bottom: NSLayoutConstraint, trailing: NSLayoutConstraint) {
      (self.top, self.bottom) = (top, bottom)
      (self.leading, self.trailing) = (leading, trailing)
    }

    /// Convenience initializer where the single constraint will be extracted.
    @inlinable public convenience init(vertical: NSLayoutConstraint.Vertical, directional: NSLayoutConstraint.Directional) {
      self.init(top: vertical.top, leading: directional.leading, bottom: vertical.bottom, trailing: directional.trailing)
    }

    @inlinable public convenience init?<S>(_ sequence: S) where S : Sequence, S.Element == NSLayoutConstraint {
      var iterator = sequence.makeIterator()
      guard let top = iterator.next(),
            let leading = iterator.next(),
            let bottom = iterator.next(),
            let trailing = iterator.next() else { return nil }
      self.init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    @inlinable public func makeIterator() -> LayoutIteratorQuartet<NSLayoutConstraint> {
      LayoutIteratorQuartet(self.top, self.leading, self.bottom, self.trailing)
    }

    public static var defaultSuffixes: Identifier {
      (".top", ".leading", ".bottom", ".trailing")
    }
  }
}
