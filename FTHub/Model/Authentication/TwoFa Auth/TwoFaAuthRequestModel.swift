//
//  EmailAuthRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct TwoFaAuthPostData: Codable {
    let email: String
    let token: Int
    
    init(email: String, token: Int) {
        self.email = email
        self.token = token
    }
}

struct TwoFaAuthResponse: Codable {
    let status: String
//    let message: String
    let token: String?
    let data: TwoFaData?
}

struct TwoFaData: Codable {
    let user: User
}
