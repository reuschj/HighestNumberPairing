import XCTest

import HighestNumberPairingTests

var tests = [XCTestCaseEntry]()
tests += HighestNumberPairingTests.allTests()
tests += NumberPairingTests.allTests()
XCTMain(tests)
