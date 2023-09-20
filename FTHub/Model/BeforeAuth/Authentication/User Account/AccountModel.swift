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
                await DbUserAuth.getCurrentUser() { user in
                    user.hasFullDetails = false
                }
                
                defaults.setValue(false, forKey: "userLoggedIn")
                
            }
        } else {
            defaults.setValue(false, forKey: "userLoggedIn")
            Message.send(type: "error", message: "There was an error connecting to our servers. Please try again later.")
        }
        return nil
    }
    
    static func checkDetails(_ token: String) async -> ApiUserDetails? {
        
        let response = await Authentication.checkDetails(token)
        defaults.setValue(false, forKey: "loadingPresented")
        
        if let safeResponse = response {
            if safeResponse.status == "success" {
                return safeResponse.data.userDetails
            } else {
                Message.send(type: "error", message: safeResponse.status)
            }
        }
        return nil
    }
    
}
