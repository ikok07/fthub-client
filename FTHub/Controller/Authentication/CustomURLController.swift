//
//  CustomURLController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import Foundation

struct CustomURLController {
    
    static let defaults = UserDefaults.standard
    
    static func confirmEmail(url: URL, completion: ((User?) -> Void)? = nil) async {
        let emailConfirmed = await ConfirmEmailController.confirmEmail(url: url, email: defaults.string(forKey: "userCurrentEmail") ?? "No email", completion: completion)
        defaults.setValue(false, forKey: "loadingPresented")
        defaults.setValue(SendEmailType.confirm.rawValue, forKey: "sendEmailType")
        if emailConfirmed {
            defaults.set(TokenVerifyStatus.success.rawValue, forKey: "tokenConfirmationStatus")
        } else {
            defaults.set(TokenVerifyStatus.fail.rawValue, forKey: "tokenConfirmationStatus")
        }
        defaults.setValue(false, forKey: "emailWithLinkSent")
        defaults.setValue(true, forKey: "showTokenVerifyStatus")
    }
    
    static func openResetPassword(url: URL) async {
        defaults.setValue(url.pathComponents[2], forKey: "restorePasswordToken")
        defaults.setValue(true, forKey: "showRestorePassword")
        defaults.setValue(false, forKey: "loadingPresented")
    }
    
    static func checkTwoFa(email: String, url: URL, completion: @escaping ((User?) async -> Void)) async {
        let token = url.pathComponents[2]
        await TwoFaAuthModel.authenticate(email: email, token: token, completion: completion)
    }
    
}
