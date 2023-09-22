//
//  ConfirmEmailRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import Foundation

struct ConfirmEmailPostData: NetworkCapable {
    let email: String
    
    init(email: String) {
        self.email = email
    }
}

struct ConfirmEmailResponse: NetworkCapable {
    let status: String
    let token: String
    let data: ConfirmEmailResponseData
}

struct ConfirmEmailResponseData: NetworkCapable {
    let user: MemoryUser
}
