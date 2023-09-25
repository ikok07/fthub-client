//
//  SettingsChangePasswordController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 8.09.23.
//

import Foundation

struct SettingsChangePasswordController {
    
    static func changePassword(currentPass: String, newPass: String, confirmNewPass: String) async {
        let response = await SettingsChangePasswordModel.updatePassword(currentPass: currentPass, newPass: newPass, confirmNewPass: confirmNewPass)
        if let safeResponse = response {
            if safeResponse.status == "success" {
                await K.Database.getCurrentUser() { user, context in
                    user.token = safeResponse.token
                }
                await Message.send(type: "success", message: safeResponse.message ?? "Successfully changed password")
            } else {
                await Message.send(type: "error", message: safeResponse.message ?? "Your password could not be changed at the moment")
            }
        } else {
            await Message.send(type: "error", message: "There was an error connecting to server")
        }
    }
    
}
