//
//  AuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

class ResendCodeController: ObservableObject {
    let resendAuthCodeModel: ResendTwoFaCodeModel = ResendTwoFaCodeModel()
    
    @Published var email: String?
    @Published var password: String?
    
    @Published var sendResendTwoFaCodeMsg: ((AccountAuthResponse?) -> Void)?
    
    func saveData(type: AuthOption, email: String, password: String?) {
        self.email = email
        
        if password != "" {
            self.password = password
        }
    }
    
    
    func resendCode() {
        Task {
            await resendAuthCodeModel.resendCode(email: self.email, password: self.password, sendTwoFaMsg: sendResendTwoFaCodeMsg)
        }
    }
    
}
