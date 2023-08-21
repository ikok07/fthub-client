//
//  EmailAuthRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct EmailAuthPostData: Codable {
    let email: String
    let token: Int
    
    init(email: String, token: Int) {
        self.email = email
        self.token = token
    }
}

struct EmailAuthResponse: Codable {
    let status: String
//    let message: String
    let token: String?
    let data: TwoFaData?
}

struct TwoFaData: Codable {
    let user: User
}
