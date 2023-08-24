//
//  ConfirmEmailModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import Foundation

struct ConfirmEmailModel {
    static func confirmEmail(url: URL, email: String) async -> ConfirmEmailResponse? {
        let confirmToken: String = url.pathComponents[2]
        let response = await Authentication.confirmEmail(email: email, confirmToken: confirmToken)
        return response
    }
}
