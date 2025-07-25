internal import Autolayout
internal import Testing
#if canImport(AppKit)
internal import AppKit
#elseif canImport(UIKit)
internal import UIKit
#endif

@Suite @MainActor final class Activity {
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

extension Activity {
  /// Tests the activity infix operator (true)
  @Test func testPostfixActive() {
    let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
    constraint↑
    #expect(constraint.isActive == true)
  }
  
  /// Tests the activity infix operator (false)
  @Test func testPostfixInactive() {
    let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
    constraint↓
    #expect(constraint.isActive == false)
  }
  
  /// Tests the activity infix operator (true)
  @Test func testInfixActive() {
    let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
    constraint ↑ "Custom Identifier"
    #expect(constraint.isActive == true)
    #expect(constraint.identifier == "Custom Identifier")
  }
  
  /// Tests the activity infix operator (false)
  @Test func testInfixInactive() {
    let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
    constraint ↓ "Custom Identifier"
    #expect(constraint.isActive == false)
    #expect(constraint.identifier == "Custom Identifier")
  }
}
