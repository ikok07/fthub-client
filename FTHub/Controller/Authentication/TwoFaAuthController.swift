//
//  CodeAuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import Foundation

class TwoFaAuthController: ObservableObject {
    let twoFaAuthModel: TwoFaAuthModel = TwoFaAuthModel()
    
    @Published var email: String?
    @Published var token: Int?
    
    func authenticateCode() {
        twoFaAuthModel.authenticate(email: self.email, token: self.token)
    }
    
}