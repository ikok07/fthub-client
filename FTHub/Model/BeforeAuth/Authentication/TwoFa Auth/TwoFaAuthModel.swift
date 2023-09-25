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
                    await K.Database.getAppVariables() { variables, context in
                        variables.userLoggedIn = true
                        variables.emailWithLinkSent = false
                        variables.loadingPresented = false
                    }
                } else {
                    await Message.send(type: "error", message: String(localized: "The entered link is invalid or expired"))
                    await K.Database.getAppVariables() { variables, context in
                        variables.tokenConfirmationStatus = TokenVerifyStatus.fail.rawValue
                        variables.sendEmailType = SendEmailType.twoFa.rawValue
                        variables.showTokenVerifyStatus = true
                        variables.loadingPresented = false
                    }
                }
            } else {
                await K.Database.getCurrentUser() { user, context in
                    let details = UserDetails(context: DB.shared.persistentContainer.viewContext)
                    user.userDetails = details
                    DB.shared.persistentContainer.viewContext.insert(user)
                    DB.shared.saveContext()
                }
            }
    }
    
}
