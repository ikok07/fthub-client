//
//  CalculatorsController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.09.23.
//

import Foundation

struct CalculatorsCommonController {
    static func validate(age: String? = nil, weight: String? = nil, height: String? = nil, activityLevel: ActivityLevel? = nil, hip: String? = nil, waist: String? = nil, neck: String? = nil) -> Bool {
        if age != nil && age == "" {
            Message.send(type: "alert", message: "Please insert your age")
        } else if weight != nil && weight == "" {
            Message.send(type: "alert", message: "Please insert your weight")
        } else if height != nil && height == "" {
            Message.send(type: "alert", message: "Please insert your height")
        } else if activityLevel != nil && activityLevel == .SelectActivity {
            Message.send(type: "alert", message: "Please select activity level")
        } else if hip != nil && hip == "" {
            Message.send(type: "alert", message: "Please insert your hip size")
        } else if waist != nil && waist == "" {
            Message.send(type: "alert", message: "Please insert your waist size")
        } else if neck != nil && neck == "" {
            Message.send(type: "alert", message: "Please insert your neck size")
        } else {
            return true
        }
        return false
    }
}
