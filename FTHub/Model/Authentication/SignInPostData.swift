//
//  SignInPostData.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
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
