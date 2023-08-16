//
//  TwoFaPostData.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

struct TwoFaPostData: Codable {
    let email: String
    let token: Int
    
    init(email: String, token: Int) {
        self.email = email
        self.token = token
    }
}
