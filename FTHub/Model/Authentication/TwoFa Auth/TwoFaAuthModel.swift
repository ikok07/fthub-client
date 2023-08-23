//
//  EmailAuthModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation
import SwiftUI
import SwiftData

struct TwoFaAuthModel {
    
    func authenticate(email: String?, token: Int?) {
        
        let defaults = UserDefaults.standard
        var userToken = defaults.string(forKey: "userToken")
        var userLoggedIn = defaults.bool(forKey: "userLoggedIn")
        
        Task {
            let response = await Authentication.authTwoFa(email: email ?? "", code: token ?? 0)
            if let safeResponse = response {
                if safeResponse.status == "success" {
                    Message.sendMessage(type: "success", message: String(localized: "Successful email authentication"))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            defaults.setValue(safeResponse.token ?? "", forKey: "userToken")
                            defaults.setValue(true, forKey: "userLoggedIn")
                        }
                    }
                } else {
                    Message.sendMessage(type: "error", message: String(localized: "The entered code is invalid or expired"))
                }
            }
        }
    }
    
}
