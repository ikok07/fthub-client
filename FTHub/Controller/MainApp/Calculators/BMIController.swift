//
//  BMIController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 11.09.23.
//

import Foundation

struct BMIController {
    
    // MARK: - Variables
    
    static let bmiRanges: [(String, Double, Double)] = [
        ("Severe Thinness", 0, 16),
        ("Moderate Thinness", 16, 17),
        ("Mild Thinness", 17, 18.5),
        ("Normal", 18.5, 25),
        ("Overweight", 25, 30),
        ("Obese Class I", 30, 35),
        ("Obese Class II", 35, 40),
        ("Obese Class III", 40, 100)
    ]
    
    // MARK: - Methods
    
    static func mapValueToDegrees(_ bmiValue: Double) -> Double {
        
        let minVal: Double = 12
        let maxVal: Double = 46
        
        let normalizedValue = max(min(bmiValue, maxVal), minVal)
        return (normalizedValue - minVal) / (maxVal - minVal) * 180
    }
    
    static func getArrowDegrees(value: Double) -> Double {
        if value < 16 && value > 12 {
            return (1 - ((15 - value) / 4)) * 20
        } else if value < 18 && value > 15 {
            return ((1 - ((17 - value) / 3)) * 5) + 20
        } else if value < 18.6 && value > 16.9 {
            return ((1 - ((18.5 - value) / 1.7)) * 10) + 25
        } else if value < 26 && value > 18.4 {
            return ((1 - ((25 - value) / 7.6)) * 35) + 35
        } else if value < 31 && value > 24 {
            return ((1 - ((30 - value) / 7)) * 25) + 70
        } else if value < 36 && value > 29 {
            return ((1 - ((35 - value) / 7)) * 25) + 95
        } else if value < 41 && value > 34 {
            return ((1 - ((40 - value) / 7)) * 25) + 120
        } else {
            return ((1 - ((46 - value) / 7)) * 40) + 145
        }
    }
    
    static func calculateBMI(units: Unit ,weight: Double, height: Double) -> Double {
        if units == .metric {
            return (weight / (height / 100 * height / 100))
        } else {
            return 703 * (weight / (height / 100 * height / 100))
        }
    }
    
}
