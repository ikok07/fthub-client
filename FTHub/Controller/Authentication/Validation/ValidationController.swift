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
            return (false, "Password must be at least 8 characters long!")
        }
        
        let containsLowercase = Validator.containsLowercaseCharacter(str: password)
        
        if !containsLowercase {
            return (false, "Password must contain at least 1 lowercase letter!")
        }
        
        let containsUppercase = Validator.containsUppercaseCharacter(str: password)
        
        if !containsUppercase {
            return (false, "Password must contain at least 1 uppercase letter!")
        }
        
        let containsNumber = Validator.containsDigit(str: password)
        
        if !containsNumber {
            return (false, "Password must contain at least 1 number!")
        }
        
        let containsCustomSymbol = Validator.containsSymbol(str: password)
        
        if !containsCustomSymbol {
            return (false, "Password must contain at least 1 special character.")
        }
        
        return (true, nil)
    }
    
}
