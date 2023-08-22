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
        
        
        return (true, nil)
    }
    
    static func validatePassword(password: String, passwordConfirm: String) -> (valid: Bool, message: String?) {
        return (true, nil)
    }
    
}
