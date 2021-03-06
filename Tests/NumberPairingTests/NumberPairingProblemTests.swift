//
//  HighestNumberPairingTests.swift
//  HighestNumberPairingTests
//
//  Created by Justin Reusch on 1/25/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import XCTest
@testable import NumberPairing

let largeProblemSize: Double = 900
let massiveProblemSize: Double = 9_000_000

class NumberPairingProblemTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func printWithOtherResults(size: Double = 8) -> NumberPairingProblem {
        let testProblem = NumberPairingProblem(addingUpTo: size)
        return testProblem
    }

    func printWithoutOtherResults(size: Double = 8) -> NumberPairingProblem {
        let testProblem = NumberPairingProblem(addingUpTo: size, withOtherResults: false)
        return testProblem
    }

    func testResultForEightIsCorrect() {
        self.measure {
            let testProblem = NumberPairingProblem(addingUpTo: 8, withOtherResults: true)
            let bestResult = testProblem.bestResult
            let expectedResult = 49.26722297
            let marginOfError = 0.00000001
            let difference = abs(bestResult - expectedResult)
            let testAssumption = difference < marginOfError
            XCTAssert(
                testAssumption,
                "Test failed because difference was expected to be below \(marginOfError) and was \(difference)"
            )
        }
    }

    func testThatRunCountIsUnderForty() {
        self.measure {
            let maxRunCount = 40
            let problem = self.printWithOtherResults(size: massiveProblemSize)
            let runs = problem.runsToSolve
            let testAssumption = runs < maxRunCount
            XCTAssert(testAssumption, "Run count was \(runs), which is not less than the maximum runs allowed.")
        }
    }

    func testPerformanceOfStandardProblemWithOtherResults() {
        self.measure {
            _ = self.printWithOtherResults()
        }
    }

    func testPerformanceOfLargeProblemWithOtherResults() {
        self.measure {
            _ = self.printWithOtherResults(size: largeProblemSize)
        }
    }

    func testPerformanceOfLargeProblemWithoutOtherResults() {
        self.measure {
            _ = self.printWithoutOtherResults(size: largeProblemSize)
        }
    }

    func testPerformanceOfMassiveProblemWithOtherResults() {
        self.measure {
            _ = self.printWithOtherResults(size: massiveProblemSize)
        }
    }

    func testPerformanceOfMassiveProblemWithoutOtherResults() {
        self.measure {
            _ = self.printWithoutOtherResults(size: massiveProblemSize)
        }
    }
}
