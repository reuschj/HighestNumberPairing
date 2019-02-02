import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(NumberPairingProblemTests.allTests),
        testCase(NumberPairingTests.allTests)
    ]
}
#endif
