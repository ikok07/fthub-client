//
//  EmailAuthModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation
import SwiftUI
import SwiftData

struct TwoFaAuthModel {
    
    @MainActor static func authenticate(email: String?, token: String?) async {
        let defaults = UserDefaults.standard

        let response = await Authentication.authTwoFa(email: email ?? "", token: token ?? "")
            if let safeResponse = response {
                if safeResponse.status == "success" {
                    let newMemoryUser = safeResponse.data?.user
                    if let newMemoryUser = newMemoryUser {
                        let user = User(context: DB.shared.persistentContainer.viewContext)
                        user.mongoID = newMemoryUser._id
                        user.token = safeResponse.token
                        user.name = newMemoryUser.name
                        user.email = newMemoryUser.email
                        user.photo = newMemoryUser.photo
                        user.role = newMemoryUser.role
                        await DbUserAuth.twoFaAuth(newUser: user)
                    }
                    defaults.setValue(true, forKey: "userLoggedIn")
                    defaults.setValue(false, forKey: "emailWithLinkSent")
                    defaults.setValue(false, forKey: "loadingPresented")
                } else {
                    Message.send(type: "error", message: String(localized: "The entered link is invalid or expired"))
                    defaults.setValue(TokenVerifyStatus.fail.rawValue, forKey: "tokenConfirmationStatus")
                    defaults.setValue(SendEmailType.twoFa.rawValue, forKey: "sendEmailType")
                    defaults.setValue(true, forKey: "showTokenVerifyStatus")
                    defaults.setValue(false, forKey: "loadingPresented")
                }
            } else {
                await DbUserAuth.getCurrentUser() { fetchData in
                    switch fetchData {
                    case .success(let users):
                        if !users.isEmpty {
                            let details = UserDetails(context: DB.shared.persistentContainer.viewContext)
                            users[0].userDetails = details
                            DB.shared.persistentContainer.viewContext.insert(users[0])
                            DB.shared.saveContext()
                        }
                    case .failure(let error):
                        print("Failed getting users from database while perforimg twoFa: \(error.localizedDescription)")
                    }
                }
            }
    }
    
}
