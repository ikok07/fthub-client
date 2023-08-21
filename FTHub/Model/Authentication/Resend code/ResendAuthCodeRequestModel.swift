//
//  ResendAuthCodeRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct ResendAuthCodePostData: Codable {
    let email: String
    
    init(email: String) {
        self.email = email
    }
}

struct ResendAuthCodeResponse: Codable {
    let status: String
    let message: String
}
