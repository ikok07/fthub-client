//
//  ProfileDataController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation

struct SettingsProfileDataController {
    
    static func saveUserDetails(gender: Gender, age: Int, height: Int, weight: Int, workoutsPerWeek: Int, goal: FitnessGoal, completion: (SettingsProfileDataResponse?) -> Void) async {
        if let response = await SettingsProfileDataModel.save(gender: gender.rawValue, age: age, height: height, weight: weight, workoutsPerWeek: workoutsPerWeek, goal: goal.rawValue.camelCaseToWords()) {
            Message.send(type: "success", message: "Successfully saved profile data")
            completion(response)
        } else {
            Message.send(type: "error", message: "There was an error saving profile data")
        }
    }
    
}
