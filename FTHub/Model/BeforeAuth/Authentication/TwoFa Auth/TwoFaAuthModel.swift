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
                    defaults.setValue(safeResponse.token ?? "", forKey: "userToken")
                    
                    let newMemoryUser = safeResponse.data?.user
                    if let newMemoryUser = newMemoryUser {
                        let user = User()
                        user.mongoID = newMemoryUser._id
                        user.name = newMemoryUser.name
                        user.email = newMemoryUser.email
                        user.photo = newMemoryUser.photo
                        user.role = newMemoryUser.role
                        await DbUserAuth.twoFaAuth(newUser: user)
                    }
                    
                    defaults.setValue(true, forKey: "userLoggedIn")
                    print("loggedin: \(defaults.bool(forKey: "userLoggedIn"))")
                    defaults.setValue(false, forKey: "emailWithLinkSent")
                    defaults.setValue(false, forKey: "loadingPresented")
                } else {
                    Message.send(type: "error", message: String(localized: "The entered link is invalid or expired"))
                    defaults.setValue(TokenVerifyStatus.fail.rawValue, forKey: "tokenConfirmationStatus")
                    defaults.setValue(SendEmailType.twoFa.rawValue, forKey: "sendEmailType")
                    defaults.setValue(true, forKey: "showTokenVerifyStatus")
                    defaults.setValue(false, forKey: "loadingPresented")
                }
            }
    }
    
}
