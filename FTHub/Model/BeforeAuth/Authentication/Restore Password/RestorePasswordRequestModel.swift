//
//  RestorePasswordRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import Foundation


struct RestorePasswordEmailRequest: NetworkCapable {
    let email: String
    init(email: String) {
        self.email = email
    }
}

struct RestorePasswordEmailResponse: NetworkCapable {
    let status: String
    let message: String
    let identifier: String?
}

struct ChangePasswordRequest: NetworkCapable {
    let email: String
    let password: String
    let passwordConfirm: String
}

struct ChangePasswordResponse: NetworkCapable {
    let status: String
    let token: String
    let data: ChangePasswordData
}

struct ChangePasswordData: NetworkCapable {
    let user: MemoryUser
}
