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
        
        if let safeResponse = response {
            if safeResponse.status == "success" {
                Message.sendMessage(type: "success", message: safeResponse.message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    defaults.setValue(true, forKey: "emailWithLinkSent")
                }
            } else {
                Message.sendMessage(type: "error", message: safeResponse.message)
            }
        } else {
            Message.sendMessage(type: "error", message: "There was an error sending restore password request.")
        }
    }
    
}
