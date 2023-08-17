//
//  TwoFaResponse.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

struct EmailAuthRequest: Codable {
    let status: String
    let token: String
    let data: TwoFaData
}

struct TwoFaData: Codable {
    let user: User
}
