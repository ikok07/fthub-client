//
//  AccountModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation


struct AccountModel {
    
    static let defaults = UserDefaults.standard
    
    static func authToken(_ token: String) async -> User? {
       let response =  await Authentication.authToken(token)
        defaults.setValue(false, forKey: "loadingPresented")
        
        if let safeResponse = response {
            if safeResponse.status == "success" {
                defaults.setValue(true, forKey: "userLoggedIn")
                return safeResponse.data
            } else {
                defaults.setValue(false, forKey: "userLoggedIn")
                return nil
            }
        } else {
            defaults.setValue(false, forKey: "userLoggedIn")
            Message.send(type: "error", message: "There was an error connecting to our servers. Please try again later.")
            return nil
        }
    }
    
}
