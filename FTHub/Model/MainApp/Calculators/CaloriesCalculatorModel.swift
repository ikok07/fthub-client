//
//  CaloriesCalculatorModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import Foundation

struct CaloriesCalculatorModel {
    static func getCoefficients(activityLevel: ActivityLevel) -> (Double, Double) {
        switch activityLevel {
        case .Light:
            return (1.37, 0.81)
        case .Active:
            return (1.465, 0.82)
        case .VeryActive:
            return (1.55, 0.83)
        case .UltraActive:
            return (1.9, 0.86)
        case .SelectActivity:
            return (0, 0)
        }
    }

    static func calculateBMR(gender: Gender, age: Double, weight: Double, height: Double) -> Double {
        
        let initFormula: Double = (10 * weight) + (6.25 * height) - (5 * age)
        
        if gender == .Male {
            return initFormula + 5
        } else {
            return initFormula - 161
        }
        
    }

    static func getFinalResult(selectedOption: CaloriesCalculatorResultOption, bmr: Double, coefficients: (Double, Double)) -> Double {
        
        let baseResult = bmr * coefficients.0
        
        switch selectedOption {
        case .MaintainWeight:
            return baseResult
        case .LoseWeight:
            return baseResult * coefficients.1
        }
    }
}
