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
                K.Database.getAppVariables() { variables, context in
                    variables.userLoggedIn = true
                }
                if safeResponse.data != nil { return safeResponse }
            } else {
                await K.Database.getCurrentUser() { user, context in
                    user.hasFullDetails = false
                }
                
                K.Database.getAppVariables() { variables, context in
                    variables.userLoggedIn = false
                    variables.showTokenVerifyStatus = false
                    variables.emailWithLinkSent = false
                }
                
            }
        } else {
            K.Database.getAppVariables() { variables, context in
                variables.userLoggedIn = false
                variables.showTokenVerifyStatus = false
                variables.emailWithLinkSent = false
            }
            Message.send(type: "error", message: "There was an error connecting to our servers. Please try again later.")
        }
        return nil
    }
    
    static func checkDetails(_ token: String) async -> ApiUserDetails? {
        
        let response = await Authentication.checkDetails(token)
        K.Database.getAppVariables() { variables, context in
            variables.loadingPresented = false
        }
        
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
