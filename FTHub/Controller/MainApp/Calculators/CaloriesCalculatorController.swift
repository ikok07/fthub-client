//
//  CaloriesCalculatorController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import Foundation

struct CaloriesCalculatorController {
    
    static func calculateCalories(selectedOption: CaloriesCalculatorResultOption, activityLevel: ActivityLevel, gender: Gender, age: Double, weight: Double, height: Double) -> Double {
        let coefficients = CaloriesCalculatorModel.getCoefficients(activityLevel: activityLevel)
        let bmr = CaloriesCalculatorModel.calculateBMR(gender: gender, age: age, weight: weight, height: height)
        
        let result = CaloriesCalculatorModel.getFinalResult(selectedOption: selectedOption, bmr: bmr, coefficients: coefficients)
        return result
    }
    
    
}
