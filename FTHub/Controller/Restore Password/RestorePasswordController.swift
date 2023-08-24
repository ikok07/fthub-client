//
//  RestorePasswordController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import Foundation

class RestorePasswordController {
    
    func sendEmail(email: String) async {
        await RestorePasswordModel.sendRestoreRequest(email: email)
    }
    
}
