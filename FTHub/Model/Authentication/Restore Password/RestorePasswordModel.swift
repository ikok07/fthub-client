//
//  RestorePasswordModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import Foundation

struct RestorePasswordModel {
    
    static let defaults = UserDefaults.standard
    
    static func sendRestoreRequest(email: String) async {
        let response = await Authentication.sendRestorePasswordRequest(email: email)
        defaults.setValue(false, forKey: "loadingPresented")
        
        if let safeResponse = response {
            if safeResponse.status == "success" {
                defaults.setValue(email, forKey: "userCurrentEmail")
                defaults.setValue(true, forKey: "emailWithLinkSent")
            } else if safeResponse.status == "fail" && safeResponse.identifier == "EmailNotVerified" {
                await Authentication.sendConfirmEmail(email: email)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    defaults.setValue(false, forKey: "loadingPresented")
                }
            } else {
                Message.sendMessage(type: "error", message: safeResponse.message)
            }
        } else {
            Message.sendMessage(type: "error", message: "There was an error sending restore password request.")
        }
    }
    
}
