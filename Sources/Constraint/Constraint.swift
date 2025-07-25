#if canImport(AppKit)
public import AppKit
#elseif canImport(UIKit)
public import UIKit
#else
#error("OS not supported")
#endif

/// Protocol defining the basic functionality of a constraint (or group of constraints).
public protocol LayoutConstraint: AnyObject {
  /// The constant used on the layout constraint expressions.
  associatedtype Constant: LayoutConstant
  /// Type that will identify this constraint (or group of constraints).
  associatedtype Identifier
  /// Type for enabling/disabling the constraint.
  associatedtype Activity
  /// Type setting the priority for the constant/s.
  associatedtype Priority

  /// The constant added to the multiplied second attribute participating in the constraint.
  /// Unlike the other properties, the constant can be modified after constraint creation. Setting the constant on an existing constraint performs much better than removing the constraint and adding a new one that's exactly like the old except that it has a different constant.
  var constant: Constant { get set }
  /// The name/s that identifies the constraint.
  var identifier: Identifier { get set }
  /// The active state of the constraint.
  var isActive: Activity { get set }
  /// The priority of the constraint or group of constraints.
  var priority: Priority { get set }
}

/// Defines a group where all constraints work to target the same objective.
public protocol LayoutConstraintGroup: LayoutConstraint, Sequence, ExpressibleByArrayLiteral
  where Self.Constant: LayoutConstantGroup,
        Self.Element == NSLayoutConstraint {
  /// Creates a new constraint group from the given sequence.
  ///
  /// If the sequence in the argument is not long enough, the initializer fails returning `nil`.
  init?<S>(_ sequence: S) where S:Sequence, S.Element == NSLayoutConstraint
  /// Set the identifiers of all constraints elements by suffixing the argument to the given root.
  /// - parameter root: The root identifier for all constraint elements.
  /// - parameter suffixes: The suffixes for all constraint elements.
  func identify(root: String, suffixes: Self.Identifier)
  /// The default suffixes that will be added to the component constraint if a single identifier is provided.
  static var defaultSuffixes: Identifier { get }
}

extension LayoutConstraintGroup {
  public init(arrayLiteral elements: NSLayoutConstraint...) {
    self.init(elements)!
  }

  public var constant: Self.Constant {
    get { Self.Constant(self.map(\.constant)) }
    set { zip(self, newValue).forEach { $0.constant = $1 } }
  }
}

extension LayoutConstraintGroup
  where Self.Constant.Iterator == LayoutIteratorPair<CGFloat>,
        Self.Identifier == (String?, String?),
        Self.Activity == (Bool, Bool),
        Self.Priority == (LayoutPriority, LayoutPriority),
        Self.Iterator == LayoutIteratorPair<NSLayoutConstraint> {
  public var identifier: Self.Identifier {
    get { self.makeIterator().map { $0.identifier } }
    set { self.makeIterator().zipMap(newValue) { $0.identifier = $1 } }
  }

  public var isActive: Self.Activity {
    get { self.makeIterator().map { $0.isActive } }
    set { self.makeIterator().zipMap(newValue) { $0.isActive = $1 } }
  }

  public var priority: Self.Priority {
    get { self.makeIterator().map { $0.priority } }
    set { self.makeIterator().zipMap(newValue) { $0.priority = $1 } }
  }

  public func identify(root: String, suffixes: Self.Identifier) {
    self.makeIterator().zipMap(suffixes) {
      var identifier = root
      if let suffix = $1 { identifier.append(suffix) }
      $0.identifier = identifier
    }
  }
}

extension LayoutConstraintGroup
  where Self.Identifier == (String?, String?, String?, String?),
        Self.Activity == (Bool, Bool, Bool, Bool),
        Self.Priority == (LayoutPriority, LayoutPriority, LayoutPriority, LayoutPriority),
        Self.Iterator == LayoutIteratorQuartet<NSLayoutConstraint> {
  public var identifier: Self.Identifier {
    get { self.makeIterator().map { $0.identifier } }
    set { self.makeIterator().zipMap(newValue) { $0.identifier = $1 } }
  }

  public var isActive: Self.Activity {
    get { self.makeIterator().map { $0.isActive } }
    set { self.makeIterator().zipMap(newValue) { $0.isActive = $1 } }
  }

  public var priority: Self.Priority {
    get { self.makeIterator().map { $0.priority } }
    set { self.makeIterator().zipMap(newValue) { $0.priority = $1 } }
  }

  public func identify(root: String, suffixes: Self.Identifier) {
    self.makeIterator().zipMap(suffixes) {
      var identifier = root
      if let suffix = $1 { identifier.append(suffix) }
      $0.identifier = identifier
    }
  }
}
