//
//  AuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

class ResendCodeController: ObservableObject {
    let resendAuthCodeModel: ResendAuthCodeModel = ResendAuthCodeModel()
    
    @Published var type: EmailAuthType?
    @Published var email: String?
    @Published var password: String?
    
    @Published var sendResendConfirmCodeMsg: ((ResendAuthCodeResponse?) -> Void)?
    @Published var sendResendTwoFaCodeMsg: ((AccountAuthResponse?) -> Void)?
    
    func saveData(type: AuthOption, email: String, password: String?) {
        self.type = type == .signIn ? .twofa : .confirm
        self.email = email
        
        if password != "" {
            self.password = password
        }
    }
    
    
    func resendCode() {
        Task {
            await resendAuthCodeModel.resendCode(type: self.type!, email: self.email, password: self.password, sendConfirmMsg: sendResendConfirmCodeMsg, sendTwoFaMsg: sendResendTwoFaCodeMsg)
        }
    }
    
}
