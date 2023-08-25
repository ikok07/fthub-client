//
//  RestorePasswordController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import Foundation

class RestorePasswordController {
    
    static func sendEmail(email: String) async {
        await RestorePasswordModel.sendRestoreEmail(email: email)
    }
    
    static func changePassword(password: String, confirmPassword: String) async -> Bool {
        let isSuccessful = await RestorePasswordModel.sendChangePasswordRequest(password: password, confirmPassword: confirmPassword)
        return isSuccessful
    }
    
}
