//
//  EmailAuthRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct TwoFaAuthPostData: NetworkCapable {
    let email: String
    
    init(email: String) {
        self.email = email
    }
}

struct TwoFaAuthResponse: NetworkCapable {
    let status: String
//    let message: String
    let token: String?
    let data: TwoFaData?
}

struct TwoFaData: Codable {
    let user: User
}
