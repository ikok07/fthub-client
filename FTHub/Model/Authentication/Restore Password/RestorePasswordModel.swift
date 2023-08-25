//
//  RestorePasswordModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import Foundation

struct RestorePasswordModel {
    
    static let defaults = UserDefaults.standard
    
    static func sendRestoreEmail(email: String) async {
        let response = await Authentication.sendRestorePasswordEmail(email: email)
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
                Message.send(type: "error", message: safeResponse.message)
            }
        } else {
            Message.send(type: "error", message: "There was an error sending restore password request.")
        }
    }
    
    static func sendChangePasswordRequest(password: String, confirmPassword: String) async {
        
        let response = await Authentication.changePassword(email: self.defaults.string(forKey: "userCurrentEmail") ?? "No email", password: password, confirmPassword: confirmPassword, token: self.defaults.string(forKey: "restorePasswordToken") ?? "No token")
        defaults.setValue(false, forKey: "loadingPresented")
        
        if let safeResponse = response {
            defaults.setValue(safeResponse.token, forKey: "userToken")
            Database.saveUserData(safeResponse.data.user)
            defaults.setValue(true, forKey: "userLoggedIn")
            defaults.setValue(RestorePasswordStatus.success.rawValue, forKey: "restorePasswordStatus")
            defaults.setValue(true, forKey: "showRestorePasswordStatus")
            defaults.setValue(false, forKey: "showRestorePassword")
        } else {
            defaults.setValue(RestorePasswordStatus.fail.rawValue, forKey: "restorePasswordStatus")
            defaults.setValue(false, forKey: "userLoggedIn")
            defaults.setValue(true, forKey: "showRestorePasswordStatus")
            defaults.setValue(false, forKey: "showRestorePassword")
        }
    }
    
}
