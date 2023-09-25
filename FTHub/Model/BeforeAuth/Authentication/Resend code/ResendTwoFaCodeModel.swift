//
//  ResendAuthCodeModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct ResendTwoFaCodeModel {
    
    func resendCode(email: String?, password: String?, sendTwoFaMsg: ((AccountAuthResponse?) -> Void)? = nil) async {
            let response = await resendTwoFaCode(email: email, password: password)
            if let safeResponse = response {
                if safeResponse.status == "success" {
                    Message.send(type: "success", message: safeResponse.message)
                } else {
                    Message.send(type: "error", message: safeResponse.message)
                }
            }
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
