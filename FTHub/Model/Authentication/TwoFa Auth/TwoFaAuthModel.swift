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
    
    @MainActor func authenticate(email: String?, token: Int?, completion: ((User?) -> Void)?) {
        
        let defaults = UserDefaults.standard
        
        Task {
            let response = await Authentication.authTwoFa(email: email ?? "", code: token ?? 0)
            if let safeResponse = response {
                if safeResponse.status == "success" {
                    withAnimation {
                        defaults.setValue(false, forKey: "buttonLoading")
                        defaults.setValue(safeResponse.token ?? "", forKey: "userToken")
                        
                        let newUser = safeResponse.data?.user
                        completion?(newUser)
                        
                        
                        defaults.setValue(true, forKey: "userLoggedIn")
                        print("loggedin: \(defaults.bool(forKey: "userLoggedIn"))")
                        defaults.setValue(false, forKey: "showTwoFa")
                    }
                } else {
                    Message.send(type: "error", message: String(localized: "The entered code is invalid or expired"))
                    defaults.setValue(false, forKey: "buttonLoading")
                }
            }
        }
    }
    
}
