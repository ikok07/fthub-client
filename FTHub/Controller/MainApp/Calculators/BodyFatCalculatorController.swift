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
    
}
