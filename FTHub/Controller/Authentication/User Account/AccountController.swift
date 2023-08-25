//
//  AccountController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation

final class AccountController {
    
    static func checkToken() async {
        let token = UserDefaults.standard.string(forKey: "userToken")
        await AccountModel.authToken(token ?? "")
    }
    
}
