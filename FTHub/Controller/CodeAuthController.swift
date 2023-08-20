//
//  CodeAuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import Foundation

class CodeAuthController: ObservableObject {
    
    @Published var type: EmailAuthType?
    @Published var email: String?
    @Published var token: Int?
    
    @Published var sendCodeAuthMsg: ((EmailAuthRequest?) -> Void)?
    
    func authenticateCode() {
        Task {
            let response = await Authentication.authEmail(email: email!, code: token!, type: type!)
             sendCodeAuthMsg?(response)
        }
    }
    
}
