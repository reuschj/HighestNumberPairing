//
//  NumberPairingProblem.swift
//  HighestNumberPairing
//
//  Created by Justin Reusch on 1/9/19.
//  Copyright © 2019 Justin Reusch. All rights reserved.
//

import Foundation

/**
  * A structure to define a problem by which takes two numbers that sum to a given amount (default to 8).
  * The problem must find the largest number combination (determined by multiplying the difference by the product of the two numbers)
  */
public struct NumberPairingProblem {
    let sum: Double
    var runsToSolve: Int
    
    typealias ResultsTuple = (best: Double, bestPairing: Set<NumberPairing>, other: [NumberPairing]?)
    /// Private property to store results
    private var results: ResultsTuple!
    
    /// Accesses best result
    public var bestResult: Double { results.best }
    /// Accesses an array of winning number pairings
    public var bestNumberPairings: Set<NumberPairing> { results.bestPairing }
    /// Accesses an array of other number pairings
    public var otherNumberPairings: [NumberPairing]? { results.other }


    // Initializers ---------------------------------------------------------- /

    public init(addingUpTo initialSum: Double = NumberPairing.defaultSum, withOtherResults collectOtherResults: Bool = true) {
        self.sum = initialSum
        self.runsToSolve = 0
        self.results = self.getResults(withOtherResults: collectOtherResults)
    }

    // Methods --------------------------------------------------------------- /

    /**
      * This method is called during initialization to get the results of the problem
      * Returns a tuple with the best result, an array of best result pairings and an array of other top pairings (sorted)
      * These values will be accessed by public getter properties
      */
    private mutating func getResults(withOtherResults collectOtherResults: Bool = true) -> (Double, Set<NumberPairing>, [NumberPairing]?) {

        // This is a NumberPairing instance that will always have a result of 0
        // We will use this as the initial high NumberPairing to beat
        let initialHighValue = NumberPairing(oneNumber: 0, addingUpTo: sum)

        // These constants for lower and upper bounds set the boundaries for numbers in the number pairing
        // We will use these to ensure we don't get a NumberPairing with a number outside of these bounds
        let lowerBounds: Double = 0
        let upperBounds: Double = sum / 2

        // These variable will hold the current overall best result that the recursive function will compare to and set as needed
        // At the end, these values will be returned in a tuple
        var overallBestResult: NumberPairing = initialHighValue
        var bestResults = Set<NumberPairing>()
        var otherResults: Set<NumberPairing>? = collectOtherResults ? Set<NumberPairing>() : nil

        // This is a failsafe. Hopefully, we end recursion before we get here, but just in case, it sets a limit on recursion
        var runCount = 0
        var maxRuns = 40

        // This is a recursive function that will start with low precision, look for the max value,
        // then continue looking for higher max values (at a higher precision) around that max value.
        // When further recursion no longer finds a better value, recursion ends (as the max value has been found)
        func getHighestResultOfSequence(from lowValue: Double, to highValue: Double, by precision: Double) -> Void {

            // If we hit the max run count, we will return and stop recursion
            guard runCount < maxRuns else { return }
            runCount += 1

            // We will set three local variables that will be for each recursive run... these will be compared to the overall variables for the method
            var bestResultFromSequence: NumberPairing = initialHighValue
            var bestResultsFromSequence = Set<NumberPairing>()
            var otherResultsFromSequence: Set<NumberPairing>? = collectOtherResults ? Set<NumberPairing>() : nil

            // Closure to determine if we can add to the other sequence
            let canBeAddedToOther: (NumberPairing) -> Bool = { (pairing) in
                return pairing != initialHighValue && precision >= 0.01 && collectOtherResults
            }

            // Set the search range and loop through each value in it
            let searchRange: StrideThrough<Double> = stride(from: lowValue, through: highValue, by: precision)
            for number in searchRange {

                // Create a new NumberPairing to evaluate
                let thisResult = NumberPairing(oneNumber: number, addingUpTo: sum)
                if thisResult > bestResultFromSequence {
                    // If the new Result is better than any other in the sequence, it's the new max
                    // We'll set it to the best in sequence and move and previous best results to the other results array
                    // Then add the new result to the best results array
                    bestResultFromSequence = thisResult
                    for result in bestResultsFromSequence {
                        if (canBeAddedToOther(result)) {
                            otherResultsFromSequence?.insert(result)
                        }
                    }
                    bestResultsFromSequence.removeAll()
                    bestResultsFromSequence.insert(thisResult)

                } else if thisResult == bestResultFromSequence {

                    // If we found a NumberPairing that matches, but doesn't exceed, the existing best, we'll add it to the best results array
                    bestResultsFromSequence.insert(thisResult)

                } else if canBeAddedToOther(thisResult) {

                    // Else, we'll just add it to the other results array
                    otherResultsFromSequence?.insert(thisResult)

                }
            }

            // When the best result from the sequence is lower or equal to the overall result (or close enough), we found the max and can stop
            let conditionToEndRecursion = bestResultFromSequence <= overallBestResult || bestResultFromSequence.isEquivalentTo(overallBestResult)
            if conditionToEndRecursion {
                runsToSolve = runCount
                return
            }

            // In this case, the sequence produced a higher result than the previous, so we'll set it to the new overall best
            // We'll also move the previous best results from the best results array to the other results array
            // and add the new best results to the best results array
            overallBestResult = bestResultFromSequence
            for result in bestResults {
                if (canBeAddedToOther(result)) {
                    otherResults?.insert(result)
                }
            }
            bestResults.removeAll()
            bestResults.formUnion(bestResultsFromSequence)
            if let possibleOtherResultsFromSequence = otherResultsFromSequence {
                otherResults?.formUnion(possibleOtherResultsFromSequence)
            }

            // This finds what the first number was from the best result. This the number we'll target when call the function again
            let bestNumberFromSequence: Double = bestResultFromSequence.first
            // We will run the function again with more precision...
            let newPrecision: Double = precision / Double(runCount * 4)
            // We'll look to half the current precision on either side of the best value
            let marginToSearchAroundBestValue: Double = precision / 2
            // ... but we'll look in a smaller range. The new result will be the best number from the sequence minus the shrink amount
            var newLowValue = bestNumberFromSequence - marginToSearchAroundBestValue
            if newLowValue < lowerBounds {
                // If new start is lower than lower bounds, snap it to lower bounds
                newLowValue = lowerBounds
            }
            // ... and new end is the best number in the sequence plus the shrink amount
            var newHighValue = bestNumberFromSequence + marginToSearchAroundBestValue
            if newHighValue > upperBounds {
                // If new end is higher than upper bounds, snap it to upper bounds
                newHighValue = upperBounds
            }

            // Call recursive function again with narrower range as defined above (but higher precision)
            getHighestResultOfSequence(from: newLowValue, to: newHighValue, by: newPrecision)

        }

        // Call the recursive function defined above
        getHighestResultOfSequence(from: lowerBounds, to: upperBounds, by: sum / 4)

        // Sort the other results
        var othersSorted: [NumberPairing]? = nil
        if let possibleOtherResults = otherResults {
            othersSorted = Array(possibleOtherResults).sorted {$0.result > $1.result}
        }

        // Return the tuple
        return (overallBestResult.result, bestResults, othersSorted)
    }
}

extension NumberPairingProblem: CustomStringConvertible {
    /// String representation
    public var description: String {
        var output = """
        \(bestResultReport)
        \(bestNumberPairingReport)
        """
        if let other = otherNumberPairingsReport {
            output += """
            \n
            \(other)
            """
        }
        return output
    }
    
    /// Accesses best result and output as a formatted string report
    public var bestResultReport: String { "\nBest Result: (Solved in \(runsToSolve) run\(runsToSolve == 1 ? "" : "s"))\n\(bestResult)\n" }
    
    /// Accesses an array of winning number pairings and outputs as formatted string report
    public var bestNumberPairingReport: String {
        var output = "Best Number Combination:"
        let _ = bestNumberPairings.map {
            output += "\n\($0)"
        }
        return output
    }
    
    /// Accesses an array of other number pairings and outputs as formatted string report
    public var otherNumberPairingsReport: String? {
        guard let allOtherResults = otherNumberPairings else { return nil }
        var output = "Other Top Results:"
        let maxResults = allOtherResults.count > 10 ? 10 : allOtherResults.count
        for index in 0 ..< maxResults {
            output += "\n\(allOtherResults[index])"
        }
        if maxResults < allOtherResults.count {
            output += "\n\u{2026}\n"
        }
        return output
    }
}
