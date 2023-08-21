//
//  AccountAuthModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct AccountAuthModel {
    
    func authenticate(activeOption: AuthOption, name: String?, email: String, password: String, confirmPassword: String?, sendMsg: ((AccountAuthResponse?) -> Void)?) {
        if activeOption == .signIn {
            Task {
                let response = await Authentication.signIn(email: email, password: password)
                sendMsg?(response)
            }
        } else if activeOption == .signUp {
            Task {
                let response = await Authentication.signUp(name: name ?? "", email: email, password: password, passwordConfirm: confirmPassword ?? "")
                sendMsg?(response)
            }
        }
    }
    
}
