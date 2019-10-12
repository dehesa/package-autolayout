import XCTest
import Autolayout

/// Asserts than `lhs` is identical to `rhs`.
func assertIdentity(_ lhs: AnyObject?, _ rhs: AnyObject?, _ message: @autoclosure ()->String = "Argument are not identical", file: StaticString = #file, line: UInt = #line) {
    XCTAssertTrue(lhs === rhs, message(), file: file, line: line)
}

/// Asserts that the values of the passed constraint are the ones of the given arguments.
func assertConstraint(_ constraint: NSLayoutConstraint, _ first: (item: AnyObject?, attribute: NSLayoutConstraint.Attribute), _ relation: NSLayoutConstraint.Relation, _ second: (item: AnyObject?, attribute: NSLayoutConstraint.Attribute)?, multiplier: CGFloat, constant: CGFloat, priority: LayoutPriority, file: StaticString = #file, line: UInt = #line) {
    assertIdentity(constraint.firstItem, first.item, file: file, line: line)
    XCTAssertEqual(constraint.firstAttribute, first.attribute, file: file, line: line)
    XCTAssertEqual(constraint.relation, relation, file: file, line: line)
    if let second = second {
        assertIdentity(constraint.secondItem, second.item, file: file, line: line)
        XCTAssertEqual(constraint.secondAttribute, second.attribute, file: file, line: line)
    }
    XCTAssertEqual(constraint.multiplier, multiplier, accuracy: .epsilon, "Constraint multiplier is \(constraint.multiplier) when it should be \(multiplier)", file: file, line: line)
    XCTAssertEqual(constraint.constant, constant, accuracy: .epsilon, "Constant is \(constraint.constant) when it should be \(constant)", file: file, line: line)
    XCTAssertEqual(constraint.priority.rawValue, priority.rawValue, "Priority is \(constraint.priority.rawValue) when it should be \(priority.rawValue)", file: file, line: line)
}
