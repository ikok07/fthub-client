//
//  SecureTextFieldController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import Foundation

class SecureTextFieldController: ObservableObject {
    
    var errorMessages: [String]? = Array(repeating: "", count: 2)
    
    var currentPassword: String?
    var confirmPassword: String?
    
    func initMsgs(textFieldCount: Int) {
        errorMessages = Array(repeating: "", count: textFieldCount)
    }
    
    
}
