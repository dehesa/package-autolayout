#if canImport(AppKit)
public import AppKit
public typealias EdgeInsets = NSEdgeInsets
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets
#elseif canImport(UIKit)
public import UIKit
public typealias EdgeInsets = UIEdgeInsets
public typealias DirectionalEdgeInsets = NSDirectionalEdgeInsets
#else
#error("OS not supported")
#endif

extension CGFloat: LayoutConstant {}

extension CGPoint: @retroactive Sequence,
                   @retroactive ExpressibleByArrayLiteral,
                   @retroactive AdditiveArithmetic,
                   @retroactive ExpressibleByIntegerLiteral,
                   @retroactive ExpressibleByFloatLiteral,
                                LayoutConstantPair {
  public typealias Iterator = LayoutIteratorPair<CGFloat>

  @usableFromInline init(_ first: CGFloat, _ second: CGFloat) {
    self.init(x: first, y: second)
  }

  @_transparent public init(_ value: CGFloat) {
    self.init(x: value, y: value)
  }

  @_transparent var values: (CGFloat, CGFloat) {
    get { (self.x, self.y) }
    set { self.x = newValue.0; self.y = newValue.1 }
  }
}

extension CGSize: @retroactive Sequence,
                  @retroactive ExpressibleByArrayLiteral,
                  @retroactive AdditiveArithmetic,
                  @retroactive ExpressibleByIntegerLiteral,
                  @retroactive ExpressibleByFloatLiteral,
                  LayoutConstantPair {
  public typealias Iterator = LayoutIteratorPair<CGFloat>

  @usableFromInline init(_ first: CGFloat, _ second: CGFloat) {
    self.init(width: first, height: second)
  }

  @_transparent public init(_ value: CGFloat) {
    self.init(width: value, height: value)
  }

  @_transparent var values: (CGFloat, CGFloat) {
    get { (self.width, self.height) }
    set { self.width = newValue.0; self.height = newValue.1 }
  }
}

/// Represents a a vertical shift for the top and bottom vertical anchors.
public struct VerticalInsets: LayoutConstantPair {
  public typealias Iterator = LayoutIteratorPair<CGFloat>
  /// The amount of points a vertical anchor will be shifted (from the top).
  var top: CGFloat
  /// The amount of points a vertical anchor will be shifted (from the bottom).
  var bottom: CGFloat

  /// Designated initializer providing the top and bottom constant.
  /// - parameter top: The amount of points a vertical anchor will be shifted (from the top).
  /// - parameter bottom: The amount of points a vertical anchor will be shifted (from the bottom).
  public init(top: CGFloat, bottom: CGFloat) {
    (self.top, self.bottom) = (top, bottom)
  }

  @usableFromInline init(_ first: CGFloat, _ second: CGFloat) {
    self.init(top: first, bottom: second)
  }

  @_transparent public init(_ value: CGFloat) {
    self.init(top: value, bottom: -value)
  }

  @_transparent var values: (CGFloat, CGFloat) {
    get { (self.top, self.bottom) }
    set { self.top = newValue.0; self.bottom = newValue.1 }
  }

  @_transparent public static var zero: Self {
    Self(top: .zero, bottom: .zero)
  }
}

/// Represents a horizontal shift for the left and right anchors.
public struct HorizontalInsets: LayoutConstantPair {
  public typealias Iterator = LayoutIteratorPair<CGFloat>
  /// The amount of points a horizontal anchor will be shifted (from the left).
  var left: CGFloat
  /// The amount of points a horizontal anchor will be shifted (from the right).
  var right: CGFloat

  /// Designated initializer providing the left and right constant.
  /// - parameter top: The amount of points a horizontal anchor will be shifted (from the left).
  /// - parameter bottom: The amount of points a horizontal anchor will be shifted (from the right).
  public init(left: CGFloat, right: CGFloat) {
    (self.left, self.right) = (left, right)
  }

  @usableFromInline init(_ first: CGFloat, _ second: CGFloat) {
    self.init(left: first, right: second)
  }

  @_transparent public init(_ value: CGFloat) {
    self.init(left: value, right: -value)
  }

  @_transparent var values: (CGFloat, CGFloat) {
    get { (self.left, self.right) }
    set { self.left = newValue.0; self.right = newValue.1 }
  }

  @_transparent public static var zero: Self {
    Self(left: .zero, right: .zero)
  }
}

/// Represents a horizontal shift for the leading and trailing anchors.
public struct DirectionalInsets: LayoutConstantPair {
  public typealias Iterator = LayoutIteratorPair<CGFloat>
  /// The amount of points a horizontal anchor will be shifted (from the leading side).
  var leading: CGFloat
  /// The amount of points a horizontal anchor will be shifted (from the trailing side).
  var trailing: CGFloat

  /// Designated initializer providing the leading and trailing constant.
  /// - parameter top: The amount of points a horizontal anchor will be shifted (from the leading side).
  /// - parameter bottom: The amount of points a horizontal anchor will be shifted (from the trailing side).
  public init(leading: CGFloat, trailing: CGFloat) {
    (self.leading, self.trailing) = (leading, trailing)
  }

  @usableFromInline init(_ first: CGFloat, _ second: CGFloat) {
    self.init(leading: first, trailing: second)
  }

  @_transparent public init(_ value: CGFloat) {
    self.init(leading: value, trailing: -value)
  }

  @_transparent var values: (CGFloat, CGFloat) {
    get { (self.leading, self.trailing) }
    set { self.leading = newValue.0; self.trailing = newValue.1 }
  }

  @_transparent public static var zero: Self {
    Self(leading: .zero, trailing: .zero)
  }
}

/// Represents a horizontal and vertical shift for the top, left, bottom, right anchors.
extension EdgeInsets: @retroactive Sequence,
                      @retroactive ExpressibleByArrayLiteral,
                      @retroactive AdditiveArithmetic,
                      @retroactive ExpressibleByIntegerLiteral,
                      @retroactive ExpressibleByFloatLiteral,
                      @retroactive Equatable,
                      LayoutConstantQuartet {
  public typealias Iterator = LayoutIteratorQuartet<CGFloat>

  @usableFromInline init(_ first: CGFloat, _ second: CGFloat, _ third: CGFloat, _ fourth: CGFloat) {
    self.init(top: first, left: second, bottom: third, right: fourth)
  }

  @_transparent public init(_ value: CGFloat) {
    self.init(top: value, left: value, bottom: -value, right: -value)
  }

  public init(_ sequence: some Sequence<CGFloat>) {
    var iterator = sequence.makeIterator()
    guard let first = iterator.next() else {
      self.init(); return
    }

    guard let second = iterator.next() else {
      self.init(first); return
    }

    guard let third = iterator.next() else {
      self.init(top: first, left: second, bottom: -first, right: -second); return
    }

    guard let fourth = iterator.next() else {
      self.init(top: first, left: second, bottom: third, right: .zero); return
    }

    self.init(first, second, third, fourth)
  }

  @_transparent var values: (CGFloat, CGFloat, CGFloat, CGFloat) {
    get { (self.top, self.left, self.bottom, self.right) }
    set { self.top = newValue.0; self.left = newValue.1; self.bottom = newValue.2; self.right = newValue.3 }
  }

  @_transparent public static var zero: Self {
    Self(.zero)
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    (lhs.left == rhs.left) && (lhs.right == rhs.right) && (lhs.top == rhs.top) && (lhs.bottom == rhs.bottom)
  }
}

/// Represents a horizontal and vertical shift for the top, leading, bottom, trailing anchors.
extension DirectionalEdgeInsets: @retroactive Sequence,
                                 @retroactive ExpressibleByArrayLiteral,
                                 @retroactive AdditiveArithmetic,
                                 @retroactive ExpressibleByIntegerLiteral,
                                 @retroactive ExpressibleByFloatLiteral,
                                 @retroactive Equatable,
                                 LayoutConstantQuartet {
  public typealias Iterator = LayoutIteratorQuartet<CGFloat>

  @usableFromInline init(_ first: CGFloat, _ second: CGFloat, _ third: CGFloat, _ fourth: CGFloat) {
    self.init(top: first, leading: second, bottom: third, trailing: fourth)
  }

  @_transparent public init(_ value: CGFloat) {
    self.init(top: value, leading: value, bottom: -value, trailing: -value)
  }

  public init(_ sequence: some Sequence<CGFloat>) {
    var iterator = sequence.makeIterator()
    guard let first = iterator.next() else {
      self.init(); return
    }

    guard let second = iterator.next() else {
      self.init(first); return
    }

    guard let third = iterator.next() else {
      self.init(top: first, leading: second, bottom: -first, trailing: -second); return
    }

    guard let fourth = iterator.next() else {
      self.init(top: first, leading: second, bottom: third, trailing: .zero); return
    }

    self.init(first, second, third, fourth)
  }

  @_transparent var values: (CGFloat, CGFloat, CGFloat, CGFloat) {
    get { (self.top, self.leading, self.bottom, self.trailing) }
    set { self.top = newValue.0; self.leading = newValue.1; self.bottom = newValue.2; self.trailing = newValue.3 }
  }

  @_transparent public static var zero: Self {
    Self(.zero)
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    (lhs.leading == rhs.leading) && (lhs.trailing == rhs.trailing) && (lhs.top == rhs.top) && (lhs.bottom == rhs.bottom)
  }
}

