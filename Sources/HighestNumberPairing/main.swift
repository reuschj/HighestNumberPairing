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
    private var introString: String { "Problem:\nFind two numbers that add up to \(formatFloat(sum)), such that the product multiplied by the difference produces the largest possible value." }
    
    func run() {
        // Get the result and print
        let twoNumbersProblem = NumberPairingProblem(addingUpTo: sum, withOtherResults: otherResults)
        let report = """
        \n\(lineMedium)\n
        \(introString)
        \(twoNumbersProblem)
        \n\(lineMedium)
        """
        print(report)
    }
}

HighestNumberPairing.main()
