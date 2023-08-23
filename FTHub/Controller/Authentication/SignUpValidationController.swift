//
//  ValidationController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

final class SignUpValidationController {
    
    static func validate(name: String, email: String, password: String, confirmPassword: String) -> (message: String, type: String)? {
        if name == "" {
            print("test")
            return (message: "Please insert name", type: "error")
        }
        return nil
    }
}
