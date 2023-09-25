//
//  RestorePasswordModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import Foundation

struct RestorePasswordModel {
    
    static func getRestorePasswordData() async -> (String, String) {
        var email: String = ""
        var token: String = ""
            await K.Database.getAppVariables() { variables, context in
                email = variables.userCurrentEmail ?? ""
                token = variables.restorePasswordToken ?? ""
            }
        return (email, token)
    }
    
    
    static func sendRestoreEmail(email: String) async {
        let response = await Authentication.sendRestorePasswordEmail(email: email)
        await K.Database.getAppVariables() { variables, context in
            variables.loadingPresented = false
        }
        
        if let safeResponse = response {
            if safeResponse.status == "success" {
                await K.Database.getAppVariables() { variables, context in
                    variables.userCurrentEmail = email
                    variables.emailWithLinkSent = true
                }
            } else if safeResponse.status == "fail" && safeResponse.identifier == "EmailNotVerified" {
                await Authentication.sendConfirmEmail(email: email)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Task {
                        await K.Database.getAppVariables() { variables, context in
                            variables.loadingPresented = true
                        }
                    }
                }
            } else {
                await Message.send(type: "error", message: safeResponse.message)
            }
        } else {
            await Message.send(type: "error", message: "There was an error sending restore password request.")
        }
    }
    
    static func sendChangePasswordRequest(password: String, confirmPassword: String) async {
        
        let response = await Authentication.changePassword(email: getRestorePasswordData().0, password: password, confirmPassword: confirmPassword, token: getRestorePasswordData().1)
        await K.Database.getAppVariables() { variables, context in
            variables.loadingPresented = false
        }
        
        if let safeResponse = response {
            let newMemoryUser = safeResponse.data.user
            let newUser = User(context: DB.shared.context)
            newUser.mongoID = newMemoryUser._id
            newUser.token = safeResponse.token
            newUser.name = newMemoryUser.name
            newUser.email = newMemoryUser.email
            newUser.photo = newMemoryUser.photo
            newUser.role = newMemoryUser.role
            await DbUserAuth.restorePassword(newUser: newUser)
            await K.Database.getAppVariables() { variables, context in
                variables.restorePasswordStatus = RestorePasswordStatus.success.rawValue
                variables.showRestorePasswordStatus = true
                variables.showRestorePassword = false
            }
        } else {
            await K.Database.getAppVariables() { variables, context in
                variables.userLoggedIn = false
                variables.restorePasswordStatus = RestorePasswordStatus.fail.rawValue
                variables.showRestorePasswordStatus = true
                variables.showRestorePassword = false
            }
        }
    }
    
}
