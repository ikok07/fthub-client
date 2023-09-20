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
            let user = User(context: DB.shared.persistentContainer.viewContext)
            user.mongoID = result.data.user._id
            user.name = result.data.user.name
            user.email = result.data.user.email
            user.photo = result.data.user.photo
            user.role = result.data.user.role
            user.token = result.token
            return DbUserAuth.confirmEmail(newUser: user)
        }
        return false
    }
    
}
