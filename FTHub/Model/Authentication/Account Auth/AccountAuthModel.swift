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
                sendMsg(method: activeOption, response: response, email: email)
            }
        } else if activeOption == .signUp {
            Task {
                let response = await Authentication.signUp(name: name ?? "", email: email, password: password, passwordConfirm: confirmPassword ?? "")
                sendMsg(method: activeOption, response: response, email: email)
            }
        }
    }
    
    private func sendMsg(method: AuthOption, response: AccountAuthResponse?, email: String) {
        if response != nil {
            if response!.status == "fail" && response!.identifier != "EmailNotVerified"{
                Message.sendMessage(type: "error", message: response!.message)
            } else if response!.identifier == "EmailNotVerified"{
                Task {
                    let emailSentResponse = await Authentication.resendConfirmEmail(email: email)
                    if emailSentResponse != nil && emailSentResponse?.status == "success" {
                        defaults.setValue(email, forKey: "userCurrentEmail")
                        defaults.setValue(true, forKey: "emailNotVerified")
                    } else {
                        Message.sendMessage(type: "error", message: "Error connecting to server")
                    }
                }
            } else {
                Message.sendMessage(type: "success", message: response!.message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if method == .signIn {
                        defaults.setValue(true, forKey: "showTwoFa")
                    } else {
                        defaults.setValue(email, forKey: "userCurrentEmail")
                        defaults.setValue(true, forKey: "emailNotVerified")
                    }
                }
            }
        } else {
                Message.sendMessage(type: "error", message: "Error connecting to server")
        }
    }
    
}
