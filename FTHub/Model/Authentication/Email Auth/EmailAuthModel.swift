//
//  EmailAuthModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct EmailAuthModel {
    
    func authenticate(email: String?, token: Int?, sendMsg: ((EmailAuthResponse?) -> Void)?) {
        Task {
            let response = await Authentication.authEmail(email: email ?? "", code: token ?? 0)
             sendMsg?(response)
        }
    }
    
}