//
//  NumberPairing.swift
//  HighestNumberPairing
//
//  Created by Justin Reusch on 1/9/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

/**
 * A structure that stores two numbers that sum to a given amount.
 * Finds the product, the difference and the result of multiplying the difference and the product.
 */
public struct NumberPairing {

    private var stored: Double
    public let sum: Double

    public var first: Double {
        get { stored }
        set { stored = validateAndCorrect(newValue) }
    }

    public var second: Double {
        get { sum - stored }
        set { stored = sum - validateAndCorrect(newValue) }
    }

    public var product: Double { stored * second }
    public var difference: Double { abs(stored - second) }
    public var result: Double { product * difference }

    // Initializers ---------------------------------------------------------- /

    public init(oneNumber: Double, addingUpTo sum: Double = NumberPairing.defaultSum) {
        self.stored = oneNumber
        self.sum = sum
        self.stored = validateAndCorrect(oneNumber)
    }

    // Methods --------------------------------------------------------------- /

    /// Finds the difference between two NumberPairings
    public func difference(_ other: NumberPairing) -> Double { abs(result - other.result) }

    /// This will test if two results are close enough to be considered equal to each other
    /// The two NumberPairings may still be !=
    public func isEquivalentTo(_ other: NumberPairing) -> Bool { difference(other) < NumberPairing.minimumPrecision }

    // Private Methods ------------------------------------------------------- /

    /// This will set a bound to ensures that the number is positive and not more than the sum
    private func validateAndCorrect(_ userInput: Double) -> Double {
        let nonNegative = abs(userInput)
        return nonNegative > sum ? sum : nonNegative
    }

    // Static Methods -------------------------------------------------------- /

    /// The default version of this problem is two numbers that add to 8
    public static let defaultSum: Double = 8

    /// The minimum level of precision we care about... beyond this point, we'll consider values equal
    static let minimumPrecision = 0.0000000001
}

extension NumberPairing: Equatable, Comparable {
    /// Method for checking equality
    public static func == (lhs: NumberPairing, rhs: NumberPairing) -> Bool {
        let sumsAreEqual = lhs.sum == rhs.sum
        let storedAreEqual = lhs.stored == rhs.stored
        let storedIsEqualToInverse = lhs.stored == rhs.second
        return (sumsAreEqual && storedAreEqual) || (sumsAreEqual && storedIsEqualToInverse)
    }

    /// Method for comparison
    public static func < (lhs: NumberPairing, rhs: NumberPairing) -> Bool { lhs.result < rhs.result }
}

extension NumberPairing: Hashable {
    /// For hashable conformance
    public func hash(into hasher: inout Hasher) {
        hasher.combine(stored)
        hasher.combine(sum)
    }
}

extension NumberPairing: CustomStringConvertible {
    /// String representation
    public var description: String { shortReport }

    /// Creates a long report with both numbers, the product, difference and the result
    public var longReport: String {
        let precision = 4
        let firstRounded = formatFloat(first, to: precision)
        let secondRounded = formatFloat(second, to: precision)
        let sumRounded = formatFloat(sum, to: precision)
        let productRounded = formatFloat(product, to: precision)
        let differenceRounded = formatFloat(difference, to: precision)
        let resultRounded = formatFloat(result, to: precision)
        return """
        Numbers: \(firstRounded) and \(secondRounded) -> \(sumRounded)
        Product: \(productRounded)
        Difference: \(differenceRounded)
        Result: \(resultRounded)\n
        """
    }

    /// Creates a short report with both numbers and the result
    public var shortReport: String {
        let precision = 4
        let firstRounded = formatFloat(first, to: precision)
        let secondRounded = formatFloat(second, to: precision)
        let sumRounded = formatFloat(sum, to: precision)
        let productRounded = formatFloat(product, to: precision)
        let differenceRounded = formatFloat(difference, to: precision)
        let resultRounded = formatFloat(result, to: precision)
        return "\(firstRounded) and \(secondRounded) -> \(sumRounded) (Difference: \(differenceRounded), Product: \(productRounded) -> Result: \(resultRounded))"
    }
}
