#if canImport(AppKit)
internal import AppKit
typealias Window = NSWindow
extension NSWindow {
  convenience init(frame: NSRect) {
    self.init(contentRect: frame, styleMask: [], backing: .buffered, defer: true)
  }

  func addSubview(_ subview: LayoutView) {
    self.contentView!.addSubview(subview)
  }
}

#elseif canImport(UIKit)
internal import UIKit
typealias Window = UIWindow
#endif
internal import Autolayout
internal import Testing

/// Test the Autolayout dimension operations.
@Suite @MainActor final class Expressions {
  let window: Window
  let viewA: LayoutView
  let viewB: LayoutView

  init() {
    self.window = Window(frame: .init(x: 0, y: 0, width: 400, height: 300))
    (self.viewA, self.viewB) = (LayoutView(), LayoutView())
    self.viewA.disableAutoresizingMask()
    self.viewB.disableAutoresizingMask()
    self.window.addSubview(self.viewA)
    self.window.addSubview(self.viewB)
  }
}

// MARK: - Basics

extension Expressions {
  /// Tests basic equality for width anchors.
  @Test func basicEquality() {
    let constraint: NSLayoutConstraint = viewA.widthAnchor == viewB.widthAnchor
    assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 1, constant: 0, priority: .required)
  }

  /// Tests basic queality for width anchors (related to constants).
  @Test func basicConstantEquality() {
    let constraint = viewA.widthAnchor == 100
    assertConstraint(constraint, (viewA, .width), .equal, nil, multiplier: 1, constant: 100, priority: .required)
  }

  /// Tests basic equality swapping width and height anchors.
  @Test func basicSwapEquality() {
    let constraint: NSLayoutConstraint = viewA.widthAnchor == viewB.heightAnchor
    assertConstraint(constraint, (viewA, .width), .equal, (viewB, .height), multiplier: 1, constant: 0, priority: .required)
  }

  /// Tests basic less than inequality
  @Test func basicLessThan() {
    let constraint = viewA.heightAnchor <= viewB.heightAnchor
    assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .height), multiplier: 1, constant: 0, priority: .required)
  }

  /// Tests basic queality for width anchors (related to constants).
  @Test func basicConstantLessThan() {
    let constraint = viewA.widthAnchor <= 222
    assertConstraint(constraint, (viewA, .width), .lessThanOrEqual, nil, multiplier: 1, constant: 222, priority: .required)
  }

  /// Tests basic less than inequality
  @Test func basicGreaterThan() {
    let constraint = viewA.heightAnchor >= viewB.heightAnchor
    assertConstraint(constraint, (viewA, .height), .greaterThanOrEqual, (viewB, .height), multiplier: 1, constant: 0, priority: .required)
  }

  /// Tests basic queality for width anchors (related to constants).
  @Test func basicConstantGreaterThan() {
    let constraint = viewA.widthAnchor >= 333
    assertConstraint(constraint, (viewA, .width), .greaterThanOrEqual, nil, multiplier: 1, constant: 333, priority: .required)
  }
}

extension Expressions {
  /// Tests the basic left multiplication for width anchors.
  @Test func basicLeftMultiplication() {
    let constraint = viewA.widthAnchor == 0.44 * viewB.widthAnchor
    assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 0.44, constant: 0, priority: .required)
  }

  /// Tests the basic right multiplication for height anchors.
  @Test func basicRightMultiplication() {
    let constraint = viewA.heightAnchor <= viewB.heightAnchor * 7
    assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .height), multiplier: 7, constant: 0, priority: .required)
  }

  /// Tests the basic right division for width/height anchors.
  @Test func basicDivision() {
    let constraint = viewA.widthAnchor >= viewB.heightAnchor / 3.2
    assertConstraint(constraint, (viewA, .width), .greaterThanOrEqual, (viewB, .height), multiplier: 1/3.2, constant: 0, priority: .required)
  }

  /// Tests the basic addition for width anchors.
  @Test func basicAddition() {
    let constraint = viewA.widthAnchor == viewB.widthAnchor + 5
    assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 1, constant: 5, priority: .required)
  }

  /// Tests the basic subtraction for height anchors.
  @Test func basicSubtraction() {
    let constraint = viewA.heightAnchor <= viewB.heightAnchor - 89213.2
    assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .height), multiplier: 1, constant: -89213.2, priority: .required)
  }

  /// Tests the layout expression priority setting.
  @Test func basicPriority() {
    let constraint = viewA.heightAnchor <= viewB.widthAnchor ~ .low
    assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .width), multiplier: 1, constant: 0, priority: .low)
  }

  /// Tests the layout exprission numeric priority setting.
  @Test func basicNumericPriority() {
    let constraint = viewA.heightAnchor >= viewB.heightAnchor ~ 614.23
    assertConstraint(constraint, (viewA, .height), .greaterThanOrEqual, (viewB, .height), multiplier: 1, constant: 0, priority: 614.23)
  }
}

// MARK: - Two operations

extension Expressions {
  /// Tests two operations: multiplication & addition.
  @Test func multiplicationAddition() {
    let constraint = viewA.widthAnchor == 8.98 * viewB.widthAnchor + 0.03
    assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 8.98, constant: 0.03, priority: .required)
  }

  /// Tests two operations: multiplication & subtraction.
  @Test func multiplicationSubtraction() {
    let constraint = viewA.heightAnchor <= 2.36 * viewB.heightAnchor - 76.03
    assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .height), multiplier: 2.36, constant: -76.03, priority: .required)
  }

  /// Tests two operations: division & addition
  @Test func DivisionAddition() {
    let constraint = viewA.widthAnchor >= viewB.heightAnchor / 9.02 + 7652
    assertConstraint(constraint, (viewA, .width), .greaterThanOrEqual, (viewB, .height), multiplier: 1/9.02, constant: 7652, priority: .required)
  }

  /// Tests two operations: multiplication & priority
  @Test func multiplicationPriority() {
    let constraint = viewA.heightAnchor == 0.88 * viewB.widthAnchor ~ .low
    assertConstraint(constraint, (viewA, .height), .equal, (viewB, .width), multiplier: 0.88, constant: 0, priority: .low)
  }

  /// Tests two operations: division & pririoty
  @Test func divisionNumericPriority() {
    let constraint = viewA.widthAnchor == viewB.widthAnchor / 6.6 ~ 777
    assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 1/6.6, constant: 0, priority: 777)
  }

  /// Test two operations in priority
  @Test func numericPriorityOperations() {
    let constraint = viewA.widthAnchor == viewB.widthAnchor ~ .high - 3
    assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 1, constant: 0, priority: .high - 3)
  }
}

// MARK: -

extension CGFloat {
  static let epsilon: CGFloat = 0.00001
}

extension Float {
  static let epsilon: Float = 0.00001
}
