//
//  CalculatorsController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.09.23.
//

import Foundation

struct CalculatorsCommonController {
    static func validate(age: String? = nil, weight: String? = nil, height: String? = nil, activityLevel: ActivityLevel? = nil) -> Bool {
        if age != nil && age == "" {
            Message.send(type: "alert", message: "Please insert your age")
        } else if weight != nil && weight == "" {
            Message.send(type: "alert", message: "Please insert your weight")
        } else if height != nil && height == "" {
            Message.send(type: "alert", message: "Please insert your height")
        } else if activityLevel != nil && activityLevel == .SelectActivity {
            Message.send(type: "alert", message: "Please select activity level")
        } else {
            return true
        }
        return false
    }
}
