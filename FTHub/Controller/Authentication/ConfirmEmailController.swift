//
//  ConfirmEmailController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import Foundation

class ConfirmEmailController {
    
    static let defaults = UserDefaults.standard
    
    static func confirmEmail(url: URL, email: String) async -> Bool {
        if let result = await ConfirmEmailModel.confirmEmail(url: url, email: email) {
            defaults.setValue(result.token, forKey: "userToken")
            await Database.saveUserData(result.data.user)
            return true
        }
        return false
    }
    
}
