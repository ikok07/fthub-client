//
//  SettingsChangePasswordController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 8.09.23.
//

import Foundation

struct SettingsChangePasswordController {
    
    static func changePassword(currPass: String, newPass: String, confirmNewPass: String, completion: (SettingsChangePasswordResponse) -> Void) async {
        let response = await SettingsChangePasswordModel.updatePassword(currPass: currPass, newPass: newPass, confirmNewPass: confirmNewPass)
        if let safeResponse = response {
            completion(safeResponse)
        } else {
            Message.send(type: "error", message: "There was an error connecting to server")
        }
    }
    
}
