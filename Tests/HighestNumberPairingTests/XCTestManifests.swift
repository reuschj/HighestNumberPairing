import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(HighestNumberPairingTests.allTests),
        testCase(NumberPairingTests.allTests)
    ]
}
#endif
