//
//  CodeAuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import Foundation

class CodeAuthController: ObservableObject {
    let emailAuthModel: EmailAuthModel = EmailAuthModel()
    
    @Published var type: EmailAuthType?
    @Published var email: String?
    @Published var token: Int?
    
    @Published var sendCodeAuthMsg: ((EmailAuthResponse?) -> Void)?
    
    func authenticateCode() {
        emailAuthModel.authenticate(email: self.email, token: self.token, type: self.type, sendMsg: self.sendCodeAuthMsg)
    }
    
}
