internal import Autolayout
internal import Testing
#if canImport(AppKit)
internal import AppKit
#elseif canImport(UIKit)
internal import UIKit
#endif

@Suite struct PriorityTests {
  @Test func assignment() {
    let priority: LayoutPriority = .required
    #expect(abs(priority.rawValue - LayoutPriority.required.rawValue) <= .epsilon)
  }
  
  @Test func integerAssignment() {
    let priority: LayoutPriority = 77
    #expect(abs(priority.rawValue - 77.0) <= .epsilon)
  }
  
  @Test func numericAssignment() {
    let priority: LayoutPriority = 88.877
    #expect(abs(priority.rawValue - (88.877)) <= .epsilon)
  }
  
  @Test func integerOperationAssignment() {
    let priority = LayoutPriority(97 + 32)
    #expect(abs(priority.rawValue - (97 + 32)) <= .epsilon)
  }
  
  @Test func numericOperationAssignment() {
    let priority = LayoutPriority(111.11 - 2.222)
    #expect(abs(priority.rawValue - (111.11 - 2.222)) <= .epsilon)
  }
  
  @Test func numericOperationsAssignment() {
    let priority: LayoutPriority = .low + 4.0 - 26.0 / 5.0 * 29.9
    #expect(fabsf(priority.rawValue - (LayoutPriority.low.rawValue + 4.0 - 26.0 / 5.0 * 29.9)) <= Float.epsilon)
  }
  
  @Test func integerOperations() {
    let priority: LayoutPriority = .high
    let result = priority - 5 + 2
    #expect(abs(result - (LayoutPriority.high.rawValue - 5 + 2)) <= .epsilon)
  }
  
  @Test func numericOperations() {
    let priority: LayoutPriority = .high
    let result = priority - 5.3 + 2
    #expect(abs(result - (LayoutPriority.high.rawValue - 5.3 + 2)) <= .epsilon)
  }
}

@Suite @MainActor final class PriorityConstraintTests {
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

extension PriorityConstraintTests {
  /// Tests the basic priority setting for constraints.
  @Test func testBasicConstraintPriority() {
    let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
    constraint ~ .high
    #expect(abs(constraint.priority.rawValue - LayoutPriority.high.rawValue) <= .epsilon)
  }
  
  /// Tests the numeric priority setting for constraints.
  @Test func testBasicConstraintNumberPriority() {
    let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
    constraint ~ 501.2
    #expect(abs(constraint.priority.rawValue - LayoutPriority(501.2).rawValue) <= .epsilon)
  }
}
