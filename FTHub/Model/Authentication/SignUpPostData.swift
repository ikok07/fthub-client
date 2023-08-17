//
//  SignUpPostData.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 17.08.23.
//

import Foundation

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
