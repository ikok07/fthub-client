//
//  SignInValidationController.swift
//  FTHub
//
//  Created by Martin on 22.08.23.
//

import Foundation

final class SignInValidationController: ValidationController {
    static func validate(email: String, password: String) -> String? {
        if let message = super.validateEmail(email: email).message {
            return message
        }
        
        return nil
    }
}
