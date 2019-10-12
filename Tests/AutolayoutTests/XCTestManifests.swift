import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ActivityTests.allTests),
        testCase(ExpressionTests.allTests),
        testCase(PriorityTests.allTests),
        testCase(PriorityConstraintTests.allTests)
    ]
}
#endif
