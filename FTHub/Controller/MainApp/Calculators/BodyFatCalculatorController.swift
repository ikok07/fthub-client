//
//  BodyFatCalculatorController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.09.23.
//

import Foundation


struct BodyFatCalculatorController {
    
    static func calculateFat(units: Unit, gender: Gender, height: Double, neck: Double, waist: Double, hip: Double) -> Double {
        if units == .metric {
            if gender == .Male {
                return (495 / (1.0324 - 0.19077 * log10(waist - neck) + 0.15456 * log10(height))) - 450
            } else {
                return (495 / (1.29579 - 0.35004 * log10(waist + hip - neck) + 0.22100 * log10(height))) - 450
            }
        } else {
            if gender == .Male {
                return 86.010 * log10(waist - neck) - 70.041 * log10(height) + 36.76
            } else {
                return 163.205 * log10(waist + hip - neck) - (97.684 * log10(height)) - 78.687
            }
        }
    }
    
    static func getSelectorPosition(result: Double) -> Double {
        if result < 0 || result > 50 {
            return 0
        }
        
        if result <= 2 {
            return (1 - (2 - result) / 2) * 0.03
        } else if result <= 6 {
            return (1 - (6 - result) / 4) * 0.12 + 0.03
        } else if result <= 14 {
            return (1 - (14 - result) / 8) * 0.25 + 0.15
        } else if result <= 18 {
            return (1 - (18 - result) / 4) * 0.2 + 0.4
        } else if result <= 25 {
            return (1 - (25 - result) / 7) * 0.15 + 0.6
        } else if result <= 50 {
            return (1 - (50 - result) / 25) * 0.25 + 0.75
        }
        
        return 0
    }
    
}
