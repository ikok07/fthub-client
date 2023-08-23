//
//  ValidationController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

class ValidationController {
    static func validateName(name: String) -> (valid: Bool, message: String?) {
        if name == "" {
            return (false, "Please provide a name!")
        }
        
        return (true, nil)
    }
    
    static func validateEmail(email: String) -> (valid: Bool, message: String?) {
        if (email == "") {
            return (false, "Please provide an email!")
        }
        
        let isEmail = Validator.isEmail(str: email)
        
        return (isEmail, isEmail == true ? nil : "Not a valid email!")
    }
    
    static func validatePassword(password: String) -> (valid: Bool, message: String?) {
        if (password == "") {
            return (false, "Please provide a password!")
        }
        
        if (password.count < 8) {
            return (false, "Password must be atleast 8 characters long!")
        }
        
        let containsLowercase = Validator.containsLowercaseCharacter(str: password)
        
        let containsUppercase = Validator.containsUppercaseCharacter(str: password)
        
        let containsNumber = Validator.containsDigit(str: password)
        
        let containsCustomSymbol = Validator.containsSymbol(str: password)
        
        return (true, nil)
    }
    
}
