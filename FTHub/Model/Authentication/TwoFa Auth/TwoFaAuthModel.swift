//
//  EmailAuthModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 21.08.23.
//

import Foundation

struct TwoFaAuthModel {
    
    func authenticate(email: String?, token: Int?, sendMsg: ((TwoFaAuthResponse?) -> Void)?) {
        Task {
            let response = await Authentication.authTwoFa(email: email ?? "", code: token ?? 0)
             sendMsg?(response)
        }
    }
    
}
