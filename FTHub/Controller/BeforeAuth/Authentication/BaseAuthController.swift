//
//  BaseAuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import Foundation
import Observation

@Observable class BaseAuthController {
    
    var activeOption: AuthOption?
    var name: String?
    var email: String = ""
    var password: String = ""
    var confirmPassword: String?
    
    func saveDetails(activeOption: AuthOption, name: String?, email: String, password: String, confirmPassword: String?) {
        self.activeOption = activeOption
        self.name = name
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
    
    @MainActor func authenticateUser() {
        AccountAuthModel.authenticate(activeOption: self.activeOption, name: self.name, email: self.email, password: self.password, confirmPassword: self.confirmPassword)
    }
    
}
