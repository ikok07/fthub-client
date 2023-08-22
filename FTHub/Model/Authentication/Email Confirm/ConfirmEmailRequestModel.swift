//
//  ConfirmEmailRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import Foundation

struct ConfirmEmailPostData: Codable {
    let email: String
    
    init(email: String) {
        self.email = email
    }
}

struct ConfirmEmailResponse: Codable {
    let status: String
    let token: String
    let data: ConfirmEmailResponseData
}

struct ConfirmEmailResponseData: Codable {
    let user: User
}
