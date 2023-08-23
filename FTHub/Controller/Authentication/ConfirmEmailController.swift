//
//  ConfirmEmailController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import Foundation

class ConfirmEmailController {
    
    let confirmEmailModel: ConfirmEmailModel = ConfirmEmailModel()
    
    func confirmEmail(url: URL, email: String) async -> Bool {
        if let result = await confirmEmailModel.confirmEmail(url: url, email: email) {
            return true
        }
        return false
    }
    
}
