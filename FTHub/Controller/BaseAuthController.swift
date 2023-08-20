//
//  BaseAuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import Foundation

class BaseAuthController: ObservableObject {
    
    @Published var activeOption: AuthOption?
    @Published var name: String?
    @Published var email: String?
    @Published var password: String?
    @Published var confirmPassword: String?
    
    @Published var sendBaseAuthMsg: ((AccountAuthResponse?) -> Void)?
    
    func authenticateUser() {
        if activeOption == .signIn {
            Task {
                let response = await Authentication.signIn(email: self.email!, password: self.password!)
                sendBaseAuthMsg?(response)
            }
        } else if activeOption == .signUp {
            Task {
                let response = await Authentication.signUp(name: self.name!, email: self.email!, password: self.password!, passwordConfirm: self.confirmPassword!)
                sendBaseAuthMsg?(response)
            }
        }
    }
    
    
}
