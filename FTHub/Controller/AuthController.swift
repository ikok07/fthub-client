//
//  AuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

class AuthController: ObservableObject {
    @Published var code: Int?
    @Published var type: EmailAuthType?
    @Published var email: String?
    @Published var password: String?
    
    
    func resendConfirmCode() async -> ResendAuthCodeResponse? {
        do {
            if let safeEmail = self.email {
                    let response = await Authentication.resendAuthCode(email: safeEmail)
                    return response
            }
        }
        return nil
    }
    
    func resendTwoFaCode() async ->  AccountAuthResponse? {
        print(email, password)
        do {
            if let safeEmail = self.email {
                let response = await Authentication.signIn(email: safeEmail, password: self.password!)
                return response
            }
        }
        return nil
    }
}
