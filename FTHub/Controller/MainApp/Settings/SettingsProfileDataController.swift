//
//  ProfileDataController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation
import UIKit


struct SettingsProfileDataController {
    
    static func sendFormData(name: String, image: UIImage?, completion: (SettingsProfileFormDataResponse) -> Void) async {
        if let response = await SettingsProfileDataModel.sendFormData(name: name, image: image) {
            if response.status == "success" {
                completion(response)
            } else {
                Message.send(type: "error", message: "There was an error uploading profile image to server")
            }
        } else {
            Message.send(type: "error", message: "There was an error connecting to server")
        }
    }
    
    static func saveUserDetails(gender: Gender, age: Int, height: Int, weight: Int, workoutsPerWeek: Int, goal: FitnessGoal, completion: (SettingsProfileDataResponse?) async -> Void) async {
        if let response = await SettingsProfileDataModel.save(gender: gender.rawValue, age: age, height: height, weight: weight, workoutsPerWeek: workoutsPerWeek, goal: goal.rawValue.camelCaseToWords()) {
            await completion(response)
        } else {
            Message.send(type: "error", message: "There was an error saving profile data")
        }
    }
    
}
