import XCTest
import Autolayout

final class ActivityTests: XCTestCase {
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
        ("testPostfixActive", testPostfixActive),
        ("testPostfixInactive", testPostfixInactive),
        ("testInfixActive", testInfixActive),
        ("testInfixInactive", testInfixInactive)
    ]
}

extension ActivityTests {
    /// Tests the activity infix operator (true)
    func testPostfixActive() {
        let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
        constraint↑
        XCTAssertEqual(constraint.isActive, true)
    }
    
    /// Tests the activity infix operator (false)
    func testPostfixInactive() {
        let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
        constraint↓
        XCTAssertEqual(constraint.isActive, false)
    }
    
    /// Tests the activity infix operator (true)
    func testInfixActive() {
        let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
        constraint ↑ "Custom Identifier"
        XCTAssertEqual(constraint.isActive, true)
        XCTAssertEqual(constraint.identifier, "Custom Identifier")
    }
    
    /// Tests the activity infix operator (false)
    func testInfixInactive() {
        let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
        constraint ↓ "Custom Identifier"
        XCTAssertEqual(constraint.isActive, false)
        XCTAssertEqual(constraint.identifier, "Custom Identifier")
    }
}