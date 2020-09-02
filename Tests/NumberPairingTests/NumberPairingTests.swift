//
//  NumberPairingUnitTests.swift
//  HighestNumberPairingTests
//
//  Created by Justin Reusch on 1/26/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import XCTest
@testable import NumberPairing

class NumberPairingUnitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatNumberPairingEqualityWorks() {
        self.measure {
            let twoAddsUpToEight = NumberPairing(oneNumber: 2, addingUpTo: 8)
            let twoAlsoAddsUpToEight = NumberPairing(oneNumber: 2, addingUpTo: 8)
            let sixAddsUpToEight = NumberPairing(oneNumber: 6, addingUpTo: 8)
            let threeAddsUpToEight = NumberPairing(oneNumber: 3, addingUpTo: 8)
            let threeAddsUpToTen = NumberPairing(oneNumber: 3, addingUpTo: 10)
            XCTAssert(twoAddsUpToEight == twoAlsoAddsUpToEight)
            XCTAssert(twoAddsUpToEight == sixAddsUpToEight)
            XCTAssert(threeAddsUpToEight != sixAddsUpToEight)
            XCTAssert(threeAddsUpToEight != threeAddsUpToTen)
        }
    }

    func testThatComparisonWorks() {
        self.measure {
            let twoAddsUpToEight = NumberPairing(oneNumber: 2, addingUpTo: 8)
            let sixAddsUpToEight = NumberPairing(oneNumber: 6, addingUpTo: 8)
            let threeAddsUpToEight = NumberPairing(oneNumber: 3, addingUpTo: 8)
            XCTAssert(
                twoAddsUpToEight >= sixAddsUpToEight,
                "twoAddsUpToEight should be greater than or equal to (it's equal) sixAddsUpToEight"
            )
            XCTAssert(
                threeAddsUpToEight < sixAddsUpToEight,
                "threeAddsUpToEight should be less than sixAddsUpToEight"
            )
            XCTAssert(
                sixAddsUpToEight > threeAddsUpToEight,
                "sixAddsUpToEight should be greater than threeAddsUpToEight"
            )
        }
    }

    func testPerformanceOfCreation() {
        // This is an example of a performance test case.
        self.measure {
            let testNumberPairing = NumberPairing(oneNumber: 2, addingUpTo: 8)
            XCTAssertEqual(testNumberPairing.first, 2.0, "First number should be 2")
            XCTAssertEqual(testNumberPairing.second, 6.0, "Second number should be 6")
            XCTAssertEqual(testNumberPairing.sum, 8.0, "Sum should be 8")
        }
    }
}
