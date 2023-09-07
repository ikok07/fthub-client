//
//  SettingsProfileDataModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation

struct SettingsProfileDataModel {
    
    static func save(gender: String, age: Int, height: Int, weight: Int, workoutsPerWeek: Int, goal: String) async -> SettingsProfileDataResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/en/api/\(K.API.apiV1)/user/detail")!
        let body: SettingsProfileDataBody = SettingsProfileDataBody(gender: gender, age: age, height: height, weight: weight, trainingFrequencyPerWeek: workoutsPerWeek, goal: goal)
        
        do {
            let response: SettingsProfileDataResponse = try await Networking.sendPatchRequest(data: body, url: url, authToken: UserDefaults.standard.string(forKey: "userToken"))
            return response
        } catch {
            print("Error updating user details: \(error)")
            return nil
        }
        
    }
    
}
