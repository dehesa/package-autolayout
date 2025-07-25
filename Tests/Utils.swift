internal import Autolayout
internal import Testing
#if canImport(AppKit)
internal import AppKit
#elseif canImport(UIKit)
internal import UIKit
#endif

/// Asserts that the values of the passed constraint are the ones of the given arguments.
func assertConstraint(_ constraint: NSLayoutConstraint, _ first: (item: AnyObject?, attribute: NSLayoutConstraint.Attribute), _ relation: NSLayoutConstraint.Relation, _ second: (item: AnyObject?, attribute: NSLayoutConstraint.Attribute)?, multiplier: CGFloat, constant: CGFloat, priority: LayoutPriority, sourceLocation: SourceLocation = #_sourceLocation) {
  #expect(constraint.firstItem === first.item)
  #expect(constraint.firstAttribute == first.attribute)
  #expect(constraint.relation == relation)
  if let second = second {
    #expect(constraint.secondItem === second.item)
    #expect(constraint.secondAttribute == second.attribute)
  }
  #expect(abs(constraint.multiplier - multiplier) <= .epsilon, "Constraint multiplier is \(constraint.multiplier) when it should be \(multiplier)")
  #expect(abs(constraint.constant - constant) <= .epsilon, "Constant is \(constraint.constant) when it should be \(constant)")
  #expect(abs(constraint.priority.rawValue - priority.rawValue) <= .epsilon, "Priority is \(constraint.priority.rawValue) when it should be \(priority.rawValue)")
}
