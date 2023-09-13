//
//  SetupModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 3.09.23.
//

import Foundation

struct SetupModel {
    
    static func saveDetailsToServer(age: Int, height: Int, weight: Int, workoutsPerWeek: Int, gender: String, units: Unit, goal: String, completion: ((Bool) -> Void)?) async {
        
        let url: URL = URL(string: "\(K.API.apiURL)/en/api/\(K.API.apiV1)/user/detail")!
        let body = ApiUserDetails(age: age, height: height, weight: weight, trainingFrequencyPerWeek: workoutsPerWeek, gender: gender, units: units.rawValue, goal: goal.camelCaseToWords())
        
        do {
            let response: ApiUserDetailsResponse = try await Networking.sendPostRequest(data: body, url: url, authToken: UserDefaults.standard.string(forKey: "userToken"))
            if response.status == "success" {
                completion?(true)
            } else {
                Message.send(type: "error", message: "Error saving details to server. Please try again later!")
                completion?(false)
            }
        } catch {
            print("Error making request to API: \(error)")
        }
    }
    
    static func getDetailsFromServer() async {
        
        let url: URL = URL(string: "\(K.API.apiURL)/\(K.API.language?.first?.prefix(2) ?? "en")/api/v1/user/detail")!

        
    }
    
}
