//
//  roundToString.swift
//  HighestNumberPairing
//
//  Created by Justin Reusch on 3/3/20.
//

import Foundation

/// Drops the trailing zero doubles when outputing to string
/// For example 16.0 -> "16" or 12.20 to "12.2"
func roundToString(number: Double, precision: Double = 1_000) -> String {
    let reduced = (number * precision).rounded() / precision
    return reduced.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%0.0f", reduced) : String(reduced)
}
