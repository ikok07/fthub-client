//
//  AccountAuthModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct AccountAuthModel {
    
    private let defaults = UserDefaults.standard
    
    func authenticate(activeOption: AuthOption, name: String?, email: String, password: String, confirmPassword: String?) {
        if activeOption == .signIn {
            Task {
                let response = await Authentication.signIn(email: email, password: password)
                advanceSignIn(method: activeOption, response: response, email: email)
            }
        } else if activeOption == .signUp {
            Task {
                let response = await Authentication.signUp(name: name ?? "", email: email, password: password, passwordConfirm: confirmPassword ?? "")
                if response != nil {
                    if response!.status == "fail" {
                        defaults.setValue(false, forKey: "loadingPresented")
                        Message.send(type: "error", message: response!.message)
                    } else {
                        await Authentication.sendConfirmEmail(email: email)
                    }
                }
            }
        }
    }
    
    
    
    private func advanceSignIn(method: AuthOption, response: AccountAuthResponse?, email: String) {
        if response != nil {
            if response!.status == "fail" && response!.identifier != "EmailNotVerified"{
                defaults.setValue(false, forKey: "loadingPresented")
                Message.send(type: "error", message: response!.message)
            } else if response!.identifier == "EmailNotVerified"{
                Task {
                    await Authentication.sendConfirmEmail(email: email)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        defaults.setValue(false, forKey: "loadingPresented")
                    }
                }
            } else {
                    if method == .signIn {
                        defaults.setValue(true, forKey: "showTwoFa")
                    } else {
                        defaults.setValue(email, forKey: "userCurrentEmail")
                        defaults.setValue(true, forKey: "emailWithLinkSent")
                    }
                defaults.setValue(false, forKey: "loadingPresented")
            }
        } else {
            defaults.setValue(false, forKey: "loadingPresented")
                Message.send(type: "error", message: "Error connecting to server")
        }
    }
    
}
