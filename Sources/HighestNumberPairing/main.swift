//
//  main.swift
//  HighestNumberPairing
//
//  Created by Justin Reusch on 1/9/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation
import NumberPairing
import ArgumentParser

/**
 A command line program to run the problem
 */
struct HighestNumberPairing: ParsableCommand {
    
    @Flag(name: .shortAndLong, default: false, inversion: .prefixedNo, help: "Include other top results in addition to the best result.")
    var otherResults: Bool
    
    @Argument(help: "Any positive number (Default: \(NumberPairing.defaultSum)). This program will find two numbers that add up to that number, such that the product multiplied by the difference produces the largest possible value.")
    var numberSum: Double?
    
    var sum: Double {  numberSum ?? NumberPairing.defaultSum }
    private var introString: String { "Problem:\nFind two numbers that add up to \(roundToString(number: sum)), such that the product multiplied by the difference produces the largest possible value.\n" }
    
    func run() {
        print("\n\(lineMedium)\n")
        print(introString)
        // Get the result and print
        let twoNumbersProblem = NumberPairingProblem(addingUpTo: sum, withOtherResults: otherResults)
        print(getBestNumberPairingReport(for: twoNumbersProblem))
        print("\n\(lineMedium)")
        if otherResults {
            getOtherNumberPairingsReport(for: twoNumbersProblem).map { print("\n\($0)") }
            print(lineMedium)
        }
    }
    
    // Reports ---------------------------------------------------------------------------------- //
        
    /// Accesses best result and output as a formatted string report
    private func getBestResultReport(for problem: NumberPairingProblem) -> String { "Best Result:\n\(problem.bestResult)\n\(lineMedium)\n" }
    
    /// Accesses an array of winning number pairings and outputs as formatted string report
    private func getBestNumberPairingReport(for problem: NumberPairingProblem) -> String {
        var output = "Best Number Combination:"
        let _ = problem.bestNumberPairings.map {
            output += "\n\(getShortReport(for: $0))"
        }
        return output
    }
    
    /// Accesses an array of other number pairings and outputs as formatted string report
    private func getOtherNumberPairingsReport(for problem: NumberPairingProblem) -> String? {
        guard let allOtherResults = problem.otherNumberPairings else { return nil }
        var output = "Other Top Results:"
        let maxResults = allOtherResults.count > 10 ? 10 : allOtherResults.count
        for index in 0 ..< maxResults {
            output += "\n\(getShortReport(for: allOtherResults[index]))"
        }
        if maxResults < allOtherResults.count {
            output += "\n\u{2026}\n"
        }
        return output
    }
    
    /// Creates a long report with both numbers, the product, difference and the result
    private func getLongReport(for numberPairing: NumberPairing) -> String {
        let firstRounded = roundToString(number: numberPairing.first, precision: 100_000)
        let secondRounded = roundToString(number: numberPairing.second, precision: 100_000)
        let productRounded = roundToString(number: numberPairing.product, precision: 100_000)
        let differenceRounded = roundToString(number: numberPairing.difference, precision: 100_000)
        let resultRounded = roundToString(number: numberPairing.result, precision: 100_000)
        return """
        Numbers: \(firstRounded) and \(secondRounded)
        \(lineMedium)
        Product: \(productRounded)
        Difference: \(differenceRounded)
        \(lineMedium)
        Result: \(resultRounded)\n
        """
    }
    
    /// Creates a short report with both numbers and the result
    private func getShortReport(for numberPairing: NumberPairing) -> String {
        let firstRounded = roundToString(number: numberPairing.first, precision: 100_000)
        let secondRounded = roundToString(number: numberPairing.second, precision: 100_000)
        let resultRounded = roundToString(number: numberPairing.result, precision: 100_000)
        return "\(firstRounded) and \(secondRounded) -> \(resultRounded)"
    }
}

HighestNumberPairing.main()
