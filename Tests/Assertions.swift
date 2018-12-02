import XCTest
import Autolayout

/// Asserts than `lhs` is identical to `rhs`.
func assertIdentity(_ lhs: AnyObject?, _ rhs: AnyObject?, _ message: @autoclosure ()->String = "Argument are not identical", file: StaticString = #file, line: UInt = #line) {
    XCTAssertTrue(lhs === rhs, message, file: file, line: line)
}

/// Asserts that the values of the passed constraint are the ones of the given arguments.
func assertConstraint(_ constraint: NSLayoutConstraint, _ first: (item: AnyObject?, attribute: NSLayoutConstraint.Attribute), _ relation: NSLayoutConstraint.Relation, _ second: (item: AnyObject?, attribute: NSLayoutConstraint.Attribute)?, multiplier: CGFloat, constant: CGFloat, priority: Priority) {
    assertIdentity(constraint.firstItem, first.item)
    XCTAssertEqual(constraint.firstAttribute, first.attribute)
    XCTAssertEqual(constraint.relation, relation)
    if let second = second {
        assertIdentity(constraint.secondItem, second.item)
        XCTAssertEqual(constraint.secondAttribute, second.attribute)
    }
    XCTAssertEqual(constraint.multiplier, multiplier, accuracy: .epsilon)
    XCTAssertEqual(constraint.constant, constant, accuracy: .epsilon)
    XCTAssertEqual(constraint.priority.rawValue, priority.rawValue)
}
