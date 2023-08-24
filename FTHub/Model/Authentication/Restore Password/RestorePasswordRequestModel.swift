//
//  RestorePasswordRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import Foundation


struct RestorePasswordRequest: NetworkCapable {
    let email: String
    init(email: String) {
        self.email = email
    }
}

struct RestorePasswordResponse: NetworkCapable {
    let status: String
    let message: String
}
