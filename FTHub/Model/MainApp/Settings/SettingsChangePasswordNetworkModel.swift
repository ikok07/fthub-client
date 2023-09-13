//
//  SettingsChangePasswordNetworkModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 8.09.23.
//

import Foundation


struct SettingsChangePasswordBody: NetworkCapable {
    let currentPassword: String
    let newPassword: String
    let newPasswordConfirm: String
}

struct SettingsChangePasswordResponse: NetworkCapable {
    let status: String
    let token: String?
    let message: String?
}
