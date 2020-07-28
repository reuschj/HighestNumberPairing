//
//  formatFloat.swift
//  
//
//  Created by Justin Reusch on 7/28/20.
//

import Foundation

/// Drops the trailing zero doubles when outputting to string
/// For example 16.0 -> "16" or 12.20 to "12.2"
public func formatFloat(_ float: Double, to precision: Int = 4) -> String {
    let base = float.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%0.0f", float) : String(format: "%0.\(precision)f", float)
    return base.trimmingCharacters(in: ["0"])
}
