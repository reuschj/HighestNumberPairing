import XCTest

import NumberPairingTests

var tests = [XCTestCaseEntry]()
tests += NumberPairingProblemTests.allTests()
tests += NumberPairingTests.allTests()
XCTMain(tests)
