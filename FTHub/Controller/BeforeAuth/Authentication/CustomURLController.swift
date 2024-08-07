//
//  CustomURLController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import Foundation

struct CustomURLController {
    
    static let defaults = UserDefaults.standard
    
    static func getCurrentEmail() async -> String {
        var email: String = ""
        K.Database.getAppVariables() { variables, context in
            email = variables.userCurrentEmail ?? ""
        }
        return email
    }
    
    static func confirmEmail(url: URL) async {
        let emailConfirmed = await ConfirmEmailController.confirmEmail(url: url, email: getCurrentEmail())
        K.Database.getAppVariables() { variables, context in
            variables.loadingPresented = false
            variables.sendEmailType = SendEmailType.confirm.rawValue
        }
        if emailConfirmed {
            K.Database.getAppVariables() { variables, context in
                variables.tokenConfirmationStatus = TokenVerifyStatus.success.rawValue
            }
        } else {
            K.Database.getAppVariables() { variables, context in
                variables.tokenConfirmationStatus = TokenVerifyStatus.fail.rawValue
            }
        }
        K.Database.getAppVariables() { variables, context in
            variables.emailWithLinkSent = false
            variables.showTokenVerifyStatus = true
        }
    }
    
    static func openResetPassword(url: URL) async {
        K.Database.getAppVariables() { variables, context in
            variables.loadingPresented = false
            variables.restorePasswordToken = url.pathComponents[2]
            variables.showRestorePassword = true
        }
    }
    
    static func checkTwoFa(email: String, url: URL) async {
        let token = url.pathComponents[2]
        await TwoFaAuthModel.authenticate(email: email, token: token)
    }
    
}
