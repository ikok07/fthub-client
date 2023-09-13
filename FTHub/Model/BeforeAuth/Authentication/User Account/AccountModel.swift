//
//  AccountModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation


struct AccountModel {
    
    static let defaults = UserDefaults.standard
    
    static func authToken(_ token: String) async -> AccountTokenAuthResponse? {
       let response =  await Authentication.authToken(token)
        
        if let safeResponse = response {
            if safeResponse.status == "success" {
                defaults.setValue(true, forKey: "userLoggedIn")
                if safeResponse.data != nil { return safeResponse }
            } else {
                defaults.setValue(false, forKey: "userLoggedIn")
                defaults.setValue(false, forKey: "hasDetails")
            }
        } else {
            defaults.setValue(false, forKey: "userLoggedIn")
            Message.send(type: "error", message: "There was an error connecting to our servers. Please try again later.")
        }
        return nil
    }
    
    static func checkDetails(_ token: String) async -> UserDetails? {
        
        let response = await Authentication.checkDetails(token)
        defaults.setValue(false, forKey: "loadingPresented")
        
        var newDetails = UserDetails(setupActivePage: 0)
        
        if let safeResponse = response {
            if safeResponse.status == "success" {
                defaults.setValue(true, forKey: "hasDetails")
                switch safeResponse.data.userDetails.units {
                case "metric":
                    newDetails.units = .metric
                default:
                    newDetails.units = .imperial
                }
                newDetails.age = safeResponse.data.userDetails.age
                newDetails.gender = Gender(rawValue: safeResponse.data.userDetails.gender!)
                newDetails.goal = FitnessGoal(rawValue: safeResponse.data.userDetails.goal!.camelCased)
                newDetails.height = safeResponse.data.userDetails.height
                newDetails.weight = safeResponse.data.userDetails.weight
                newDetails.workoutsPerWeek = safeResponse.data.userDetails.trainingFrequencyPerWeek
            } else {
                Message.send(type: "error", message: safeResponse.status)
            }
        } else {
            defaults.setValue(false, forKey: "hasDetails")
        }
        return newDetails
    }
    
}
