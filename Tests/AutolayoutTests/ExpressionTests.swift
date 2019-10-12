import XCTest
import Autolayout

#if canImport(UIKit)
import UIKit
typealias Window = UIWindow
#elseif canImport(Cocoa)
import Cocoa
typealias Window = NSWindow
#else
#error("OS not supported")
#endif

/// Test the Autolayout dimension operations.
final class ExpressionTests: XCTestCase {
    let window = Window(frame: .init(x: 0, y: 0, width: 400, height: 300))
    let (viewA, viewB) = (LayoutView(), LayoutView())
    
    override func setUp() {
        self.viewA.enableAutolayout()
        self.viewB.enableAutolayout()
        self.window.addSubview(self.viewA)
        self.window.addSubview(self.viewB)
    }

    override func tearDown() {
        self.viewA.removeFromSuperview()
        self.viewB.removeFromSuperview()
    }
    
    static var allTests = [
        ("testBasicEquality", testBasicEquality),
        ("testBasicConstantEquality", testBasicConstantEquality),
        ("testBasicSwapEquality", testBasicSwapEquality),
        ("testBasicLessThan", testBasicLessThan),
        ("testBasicConstantLessThan", testBasicConstantLessThan),
        ("testBasicGreaterThan", testBasicGreaterThan),
        ("testBasicConstantGreaterThan", testBasicConstantGreaterThan),
        ("testBasicLeftMultiplication", testBasicLeftMultiplication),
        ("testBasicRightMultiplication", testBasicRightMultiplication),
        ("testBasicDivision", testBasicDivision),
        ("testBasicAddition", testBasicAddition),
        ("testBasicSubtraction", testBasicSubtraction),
        ("testBasicPriority", testBasicPriority),
        ("testBasicNumericPriority", testBasicNumericPriority),
        ("testMultiplicationAddition", testMultiplicationAddition),
        ("testMultiplicationSubtraction", testMultiplicationSubtraction),
        ("testDivisionAddition", testDivisionAddition),
        ("testMultiplicationPriority", testMultiplicationPriority),
        ("testDivisionNumericPriority", testDivisionNumericPriority),
        ("testNumericPriorityOperations", testNumericPriorityOperations)
    ]
}

extension CGFloat {
    static let epsilon: CGFloat = 0.00001
}

extension Float {
    static let epsilon: Float = 0.00001
}

// MARK: - Basics

extension ExpressionTests {
    /// Tests basic equality for width anchors.
    func testBasicEquality() {
        let constraint: NSLayoutConstraint = viewA.widthAnchor == viewB.widthAnchor
        assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 1, constant: 0, priority: .required)
    }
    
    /// Tests basic queality for width anchors (related to constants).
    func testBasicConstantEquality() {
        let constraint = viewA.widthAnchor == 100
        assertConstraint(constraint, (viewA, .width), .equal, nil, multiplier: 1, constant: 100, priority: .required)
    }
    
    /// Tests basic equality swapping width and height anchors.
    func testBasicSwapEquality() {
        let constraint: NSLayoutConstraint = viewA.widthAnchor == viewB.heightAnchor
        assertConstraint(constraint, (viewA, .width), .equal, (viewB, .height), multiplier: 1, constant: 0, priority: .required)
    }
    
    /// Tests basic less than inequality
    func testBasicLessThan() {
        let constraint = viewA.heightAnchor <= viewB.heightAnchor
        assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .height), multiplier: 1, constant: 0, priority: .required)
    }
    
    /// Tests basic queality for width anchors (related to constants).
    func testBasicConstantLessThan() {
        let constraint = viewA.widthAnchor <= 222
        assertConstraint(constraint, (viewA, .width), .lessThanOrEqual, nil, multiplier: 1, constant: 222, priority: .required)
    }
    
    /// Tests basic less than inequality
    func testBasicGreaterThan() {
        let constraint = viewA.heightAnchor >= viewB.heightAnchor
        assertConstraint(constraint, (viewA, .height), .greaterThanOrEqual, (viewB, .height), multiplier: 1, constant: 0, priority: .required)
    }
    
    /// Tests basic queality for width anchors (related to constants).
    func testBasicConstantGreaterThan() {
        let constraint = viewA.widthAnchor >= 333
        assertConstraint(constraint, (viewA, .width), .greaterThanOrEqual, nil, multiplier: 1, constant: 333, priority: .required)
    }
}

extension ExpressionTests {
    /// Tests the basic left multiplication for width anchors.
    func testBasicLeftMultiplication() {
        let constraint = viewA.widthAnchor == 0.44 * viewB.widthAnchor
        assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 0.44, constant: 0, priority: .required)
    }
    
    /// Tests the basic right multiplication for height anchors.
    func testBasicRightMultiplication() {
        let constraint = viewA.heightAnchor <= viewB.heightAnchor * 7
        assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .height), multiplier: 7, constant: 0, priority: .required)
    }
    
    /// Tests the basic right division for width/height anchors.
    func testBasicDivision() {
        let constraint = viewA.widthAnchor >= viewB.heightAnchor / 3.2
        assertConstraint(constraint, (viewA, .width), .greaterThanOrEqual, (viewB, .height), multiplier: 1/3.2, constant: 0, priority: .required)
    }
    
    /// Tests the basic addition for width anchors.
    func testBasicAddition() {
        let constraint = viewA.widthAnchor == viewB.widthAnchor + 5
        assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 1, constant: 5, priority: .required)
    }
    
    /// Tests the basic subtraction for height anchors.
    func testBasicSubtraction() {
        let constraint = viewA.heightAnchor <= viewB.heightAnchor - 89213.2
        assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .height), multiplier: 1, constant: -89213.2, priority: .required)
    }
    
    /// Tests the layout expression priority setting.
    func testBasicPriority() {
        let constraint = viewA.heightAnchor <= viewB.widthAnchor ~ .low
        assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .width), multiplier: 1, constant: 0, priority: .low)
    }
    
    /// Tests the layout exprission numeric priority setting.
    func testBasicNumericPriority() {
        let constraint = viewA.heightAnchor >= viewB.heightAnchor ~ 614.23
        assertConstraint(constraint, (viewA, .height), .greaterThanOrEqual, (viewB, .height), multiplier: 1, constant: 0, priority: 614.23)
    }
    
    ///
//    func testBasicAssignmentPriority() {
//        let constraint = viewA.widthAnchor == 100 ~ .low
//        assertConstraint(constraint, (viewA, .width), .equal, nil, multiplier: 1, constant: 100, priority: .required)
//    }
}

// MARK: - Two operations

extension ExpressionTests {
    /// Tests two operations: multiplication & addition.
    func testMultiplicationAddition() {
        let constraint = viewA.widthAnchor == 8.98 * viewB.widthAnchor + 0.03
        assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 8.98, constant: 0.03, priority: .required)
    }
    
    /// Tests two operations: multiplication & subtraction.
    func testMultiplicationSubtraction() {
        let constraint = viewA.heightAnchor <= 2.36 * viewB.heightAnchor - 76.03
        assertConstraint(constraint, (viewA, .height), .lessThanOrEqual, (viewB, .height), multiplier: 2.36, constant: -76.03, priority: .required)
    }
    
    /// Tests two operations: division & addition
    func testDivisionAddition() {
        let constraint = viewA.widthAnchor >= viewB.heightAnchor / 9.02 + 7652
        assertConstraint(constraint, (viewA, .width), .greaterThanOrEqual, (viewB, .height), multiplier: 1/9.02, constant: 7652, priority: .required)
    }
    
    /// Tests two operations: multiplication & priority
    func testMultiplicationPriority() {
        let constraint = viewA.heightAnchor == 0.88 * viewB.widthAnchor ~ .low
        assertConstraint(constraint, (viewA, .height), .equal, (viewB, .width), multiplier: 0.88, constant: 0, priority: .low)
    }
    
    /// Tests two operations: division & pririoty
    func testDivisionNumericPriority() {
        let constraint = viewA.widthAnchor == viewB.widthAnchor / 6.6 ~ 777
        assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 1/6.6, constant: 0, priority: 777)
    }
    
    /// Test two operations in priority
    func testNumericPriorityOperations() {
        let constraint = viewA.widthAnchor == viewB.widthAnchor ~ .high - 3
        assertConstraint(constraint, (viewA, .width), .equal, (viewB, .width), multiplier: 1, constant: 0, priority: .high - 3)
    }
}

// MARK: Three operations
