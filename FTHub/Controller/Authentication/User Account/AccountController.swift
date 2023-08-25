//
//  AccountController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation

final class AccountController: ObservableObject {
    
    let defaults = UserDefaults.standard
    let userToken: String = ""
    var user: User? = nil
    
    func checkToken(_ token: String) async {
        let responseUser = await AccountModel.authToken(token)
        user = responseUser
        print("USER LOGGED IN: \(defaults.bool(forKey: "userLoggedIn"))")
        print("USER DETAILS: \(user)")
    }
    
}
