#if canImport(AppKit)
public import AppKit
#elseif canImport(UIKit)
public import UIKit
#else
#error("OS not supported")
#endif

// MARK: - Single Anchors

extension NSLayoutDimension: LayoutAnchorSingle, LayoutAnchorConstant {
  @_transparent public func constraint(equalTo anchor: NSLayoutDimension, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
    self.constraint(equalTo: anchor, multiplier: multiplier ?? 1, constant: constant)
  }

  @_transparent public func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
    self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier ?? 1, constant: constant)
  }

  @_transparent public func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
    self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier ?? 1, constant: constant)
  }
}

extension NSLayoutXAxisAnchor: LayoutAnchorSingle {
  @_transparent public func constraint(equalTo anchor: NSLayoutXAxisAnchor, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
    self.constraint(equalTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier)
  }

  @_transparent public func constraint(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
    self.constraint(greaterThanOrEqualTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier)
  }

  @_transparent public func constraint(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
    self.constraint(lessThanOrEqualTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier)
  }
}

extension NSLayoutYAxisAnchor: LayoutAnchorSingle {
  @_transparent public func constraint(equalTo anchor: NSLayoutYAxisAnchor, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
    self.constraint(equalTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier)
  }

  @_transparent public func constraint(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
    self.constraint(greaterThanOrEqualTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier)
  }

  @_transparent public func constraint(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, multiplier: CGFloat?, constant: CGFloat) -> NSLayoutConstraint {
    self.constraint(lessThanOrEqualTo: anchor, constant: constant).basicDuplicationIfNeeded(withMultiplier: multiplier)
  }
}

// MARK: - Anchor Pairs

/// A layout anchor representing the width and height of the object generating this instance.
public struct LayoutSizeAnchor: LayoutAnchorPair {
  public typealias Constant = CGSize
  public typealias Constraint = NSLayoutConstraint.Size
  /// The actual width and height anchors.
  public let widthAnchor: NSLayoutDimension
  public let heightAnchor: NSLayoutDimension

  init(_ anchorA: NSLayoutDimension, _ anchorB: NSLayoutDimension) {
    (self.widthAnchor, self.heightAnchor) = (anchorA, anchorB)
  }

  var anchors: (NSLayoutDimension, NSLayoutDimension) {
    (self.widthAnchor, self.heightAnchor)
  }

  public static var isInset: Bool { false }
}

extension LayoutSizeAnchor: LayoutAnchorConstant {
  public func constraint(equalToConstant constant: CGSize) -> NSLayoutConstraint.Size {
    .init(width: self.widthAnchor.constraint(equalToConstant: constant.width), height: self.heightAnchor.constraint(equalToConstant: constant.height))
  }

  public func constraint(greaterThanOrEqualToConstant constant: CGSize) -> NSLayoutConstraint.Size {
    .init(width: self.widthAnchor.constraint(greaterThanOrEqualToConstant: constant.width), height: self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant.height))
  }

  public func constraint(lessThanOrEqualToConstant constant: CGSize) -> NSLayoutConstraint.Size {
    .init(width: self.widthAnchor.constraint(lessThanOrEqualToConstant: constant.width), height: self.heightAnchor.constraint(lessThanOrEqualToConstant: constant.height))
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

  var anchors: (NSLayoutXAxisAnchor, NSLayoutYAxisAnchor) {
    (self.x, self.y)
  }

  public static var isInset: Bool { false }
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

  var anchors: (NSLayoutYAxisAnchor, NSLayoutYAxisAnchor) {
    (self.top, self.bottom)
  }

  public static var isInset: Bool { true }
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

  var anchors: (NSLayoutXAxisAnchor, NSLayoutXAxisAnchor) {
    (self.left, self.right)
  }

  public static var isInset: Bool { true }
}

/// A layout anchor representing the leading and trailing boundaries of the object generating this instance.
public struct LayoutDirectionalAnchor: LayoutAnchorPair {
  public typealias Constant = DirectionalInsets
  public typealias Constraint = NSLayoutConstraint.Directional

  let leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor

  init(_ anchorA: NSLayoutXAxisAnchor, _ anchorB: NSLayoutXAxisAnchor) {
    (self.leading, self.trailing) = (anchorA, anchorB)
  }

  var anchors: (NSLayoutXAxisAnchor, NSLayoutXAxisAnchor) {
    (self.leading, self.trailing)
  }

  public static var isInset: Bool { true }
}

// MARK: - Anchor Quartets

public struct LayoutEdgeAnchor: LayoutAnchorQuartet {
  public typealias Constant = EdgeInsets
  public typealias Constraint = NSLayoutConstraint.Edges

  let top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor
  let left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor

  init(_ anchorA: NSLayoutYAxisAnchor, _ anchorB: NSLayoutXAxisAnchor, _ anchorC: NSLayoutYAxisAnchor, _ anchorD: NSLayoutXAxisAnchor) {
    (self.top, self.bottom) = (anchorA, anchorC)
    (self.left, self.right) = (anchorB, anchorD)
  }

  var anchors: (NSLayoutYAxisAnchor, NSLayoutXAxisAnchor, NSLayoutYAxisAnchor, NSLayoutXAxisAnchor) {
    (self.top, self.left, self.bottom, self.right)
  }

  public static var isInset: Bool { true }
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

  var anchors: (NSLayoutYAxisAnchor, NSLayoutXAxisAnchor, NSLayoutYAxisAnchor, NSLayoutXAxisAnchor) {
    (self.top, self.leading, self.bottom, self.trailing)
  }

  public static var isInset: Bool { true }
}
