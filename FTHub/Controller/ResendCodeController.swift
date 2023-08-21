//
//  AuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

class ResendCodeController: ObservableObject {
    @Published var code: Int?
    @Published var type: EmailAuthType?
    @Published var email: String?
    @Published var password: String?
    
    @Published var sendResendConfirmCodeMsg: ((ResendAuthCodeResponse?) -> Void)?
    @Published var sendResendTwoFaCodeMsg: ((AccountAuthResponse?) -> Void)?
    
    func resendCode() {
        Task {
            if type == .confirm {
                let response = await resendConfirmCode()
                sendResendConfirmCodeMsg?(response)
            } else {
                let response = await resendTwoFaCode()
                sendResendTwoFaCodeMsg?(response)
            }
        }
    }
    
    private func resendConfirmCode() async -> ResendAuthCodeResponse? {
        do {
            if let safeEmail = self.email {
                    let response = await Authentication.resendAuthCode(email: safeEmail)
                    return response
            }
        }
        return nil
    }
    
    private func resendTwoFaCode() async ->  AccountAuthResponse? {
        do {
            if let safeEmail = self.email {
                let response = await Authentication.signIn(email: safeEmail, password: self.password!)
                return response
            }
        }
        return nil
 
    }
    
}
