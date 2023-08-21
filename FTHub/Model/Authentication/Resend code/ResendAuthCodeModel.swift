//
//  ResendAuthCodeModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct ResendAuthCodeModel {
    
    func resendCode(type: EmailAuthType, email: String?, password: String?, sendConfirmMsg: ((ResendAuthCodeResponse?) -> Void)? = nil, sendTwoFaMsg: ((AccountAuthResponse?) -> Void)? = nil) async {
        if type == .confirm {
            let response = await resendConfirmCode(email: email)
            sendConfirmMsg?(response)
        } else {
            let response = await resendTwoFaCode(email: email, password: password)
            sendTwoFaMsg?(response)
        }
    }
    
    private func resendConfirmCode(email: String?) async -> ResendAuthCodeResponse? {
        do {
            if let safeEmail = email {
                    let response = await Authentication.resendAuthCode(email: safeEmail)
                    return response
            }
        }
        return nil
    }
    
    private func resendTwoFaCode(email: String?, password: String?) async ->  AccountAuthResponse? {
        do {
            if let safeEmail = email {
                let response = await Authentication.signIn(email: safeEmail, password: password!)
                return response
            }
        }
        return nil
 
    }
    
}
