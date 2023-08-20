//
//  ResendAuthCodePostData.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import Foundation
    
struct ResendAuthCodePostData: Codable {
    let email: String
    
    init(email: String) {
        self.email = email
    }
}
