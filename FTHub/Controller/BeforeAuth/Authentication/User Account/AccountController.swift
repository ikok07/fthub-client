//
//  AccountController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation

final class AccountController {
    
    static func checkToken() async -> AccountTokenAuthResponse? {
        let token = UserDefaults.standard.string(forKey: "userToken")
        let response = await AccountModel.authToken(token ?? "")
        return response
    }
    
    static func checkDetails() async -> ApiUserDetails? {
        let token = UserDefaults.standard.string(forKey: "userToken")
        let details = await AccountModel.checkDetails(token ?? "")
        return details
    }
    
}
