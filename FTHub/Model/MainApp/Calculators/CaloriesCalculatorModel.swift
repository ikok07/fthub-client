//
//  CaloriesCalculatorModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import Foundation

struct CaloriesCalculatorModel {
    static func getCoefficients(activityLevel: ActivityLevel) -> (Double, Double, Double) {
        switch activityLevel {
        case .Light:
            return (0.89, 0.78, 1.37)
        case .Active:
            return (0.9, 0.79, 1.465)
        case .VeryActive:
            return (0.9, 0.8, 1.55)
        case .UltraActive:
            return (0.91, 0.82, 1.725)
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

    static func getFinalResult(selectedOption: CaloriesCalculatorResultOption, bmr: Double, coefficients: (Double, Double, Double)) -> Double {
        switch selectedOption {
        case .MildWeightLoss:
            return bmr * coefficients.0
        case .WeightLoss:
            return bmr * coefficients.1
        case .MaintainWeight:
            return bmr * coefficients.2
        }
    }
}
