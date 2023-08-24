//
//  CustomURLController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import Foundation

struct CustomURLController {
    
    static let defaults = UserDefaults.standard
    
    static func confirmEmail(url: URL) async {
        let emailConfirmed = await ConfirmEmailController.confirmEmail(url: url, email: defaults.string(forKey: "userCurrentEmail") ?? "No email")
        defaults.setValue(false, forKey: "loadingPresented")
        if emailConfirmed {
            defaults.set(EmailConfirmStatus.success.rawValue, forKey: "emailConfirmationStatus")
        } else {
            defaults.set(EmailConfirmStatus.fail.rawValue, forKey: "emailConfirmationStatus")
        }
        defaults.setValue(false, forKey: "emailWithLinkSent")
        defaults.setValue(true, forKey: "showEmailVerifyStatus")
    }
    
    static func openResetPassword() async {
        defaults.setValue(true, forKey: "showRestorePassword")
        defaults.setValue(false, forKey: "loadingPresented")
    }
    
}
