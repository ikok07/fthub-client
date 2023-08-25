//
//  AccountModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation


struct AccountModel {
    
    static let defaults = UserDefaults.standard
    
    static func authToken(_ token: String) async {
       let response =  await Authentication.authToken(token)
        defaults.setValue(false, forKey: "loadingPresented")
        
        if let safeResponse = response {
            if safeResponse.status == "success" {
                defaults.setValue(true, forKey: "userLoggedIn")
                if safeResponse.data != nil { Database.saveUserData(safeResponse.data!) }
            } else {
                defaults.setValue(false, forKey: "userLoggedIn")
            }
        } else {
            defaults.setValue(false, forKey: "userLoggedIn")
            Message.send(type: "error", message: "There was an error connecting to our servers. Please try again later.")
        }
    }
    
}
