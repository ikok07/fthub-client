//
//  AccountAuthRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct SignInPostData: Codable {
    let email:String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

struct SignUpPostData: Codable {
    let name: String
    let email: String
    let password: String
    let passwordConfirm: String
    
    init(name: String, email: String, password: String, passwordConfirm: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirm = passwordConfirm
    }
}

struct AccountAuthResponse: Codable {
    let status: String
    let message: String
}
