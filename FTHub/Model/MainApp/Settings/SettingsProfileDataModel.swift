//
//  SettingsProfileDataModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation
import UIKit

struct SettingsProfileDataModel {
    
    
    static func sendFormData(json: Data?, image: UIImage?) async -> SettingsProfileFormDataResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/en/api/v1/user/me")!
        var imageData: Data?
        if image != nil {
            imageData = ImageMedia(withImage: image!, key: "image").data!
        }
        let formDataBody: SettingsProfileFormDataBody = SettingsProfileFormDataBody(json: json, image: imageData)
        
        do {
            let response: SettingsProfileFormDataResponse = try await Networking.sendPatchRequest(data: formDataBody, url: url, authToken: UserDefaults.standard.string(forKey: "userToken"), formData: true)
            return response
        } catch {
            print("Error uploading media to server")
            return nil
        }
    }
    
    static func save(gender: String, age: Int, height: Int, weight: Int, workoutsPerWeek: Int, units: String, goal: String) async -> SettingsProfileDataResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/en/api/\(K.API.apiV1)/user/detail")!
        let body: SettingsProfileDataBody = SettingsProfileDataBody(gender: gender, age: age, height: height, weight: weight, trainingFrequencyPerWeek: workoutsPerWeek, units: units, goal: goal)
        
        do {
            let response: SettingsProfileDataResponse = try await Networking.sendPatchRequest(data: body, url: url, authToken: UserDefaults.standard.string(forKey: "userToken"))
            return response
        } catch {
            print("Error updating user details: \(error)")
            return nil
        }
        
    }
    
}
