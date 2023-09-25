//
//  AccountAuthModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct AccountAuthModel {
    
    @MainActor static func authenticate(activeOption: AuthOption?, name: String?, email: String, password: String, confirmPassword: String?) {
        if activeOption == .signIn {
            Task {
                let response = await Authentication.signIn(email: email, password: password)
                await advanceSignIn(response: response, email: email)
            }
        } else if activeOption == .signUp {
            Task {
                let response = await Authentication.signUp(name: name ?? "", email: email, password: password, passwordConfirm: confirmPassword ?? "")
                if response != nil {
                    if response!.status == "fail" {
                        Message.send(type: "error", message: response!.message)
                        K.Database.getAppVariables() { variables, context in
                            variables.buttonLoading = false
                            variables.loadingPresented = false
                            variables.showTokenVerifyStatus = false
                        }
                    } else {
                        K.Database.getAppVariables() { variables, context in
                            variables.userCurrentEmail = email
                            variables.emailWithLinkSent = true
                            variables.buttonLoading = false
                            variables.loadingPresented = false
                            variables.showTokenVerifyStatus = false
                        }
                    }
                }
            }
        } else {
            Task {
                K.Database.getAppVariables() { variables, context in
                    variables.loadingPresented = false
                    variables.emailWithLinkSent = false
                    variables.showTokenVerifyStatus = false
                    variables.userLoggedIn = false
                }
            }
        }
    }
    
    
    
    static private func advanceSignIn(response: AccountAuthResponse?, email: String) async {
        if response != nil {
            if response!.status == "fail" && response!.identifier != "EmailNotVerified" {
                Message.send(type: "error", message: response!.message)
            } else if response!.identifier == "EmailNotVerified" {
                Task {
                    await Authentication.sendConfirmEmail(email: email)
                }
            } else {
                K.Database.getAppVariables() { variables, context in
                    variables.userCurrentEmail = email
                    variables.emailWithLinkSent = true
                }
            }
        } else {
            Message.send(type: "error", message: "Error connecting to server")
        }
        K.Database.getAppVariables() { variables, context in
            variables.buttonLoading = false
            variables.loadingPresented = false
        }
    }
    
}
