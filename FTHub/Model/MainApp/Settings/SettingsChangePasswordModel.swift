//
//  SettingsChangePasswordModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 8.09.23.
//

import Foundation

struct SettingsChangePasswordModel {
    
    static func updatePassword(currentPass: String, newPass: String, confirmNewPass: String) async -> SettingsChangePasswordResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/\(K.API.language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV1)/user/updatePassword")!
        let body: SettingsChangePasswordBody = SettingsChangePasswordBody(currentPassword: currentPass, newPassword: newPass, newPasswordConfirm: confirmNewPass)
        
        do {
            let response: SettingsChangePasswordResponse = try await Networking.sendPatchRequest(data: body, url: url, authToken: K.Database.getUserToken())
            return response
        } catch {
            print("There was an error connecting to API in order to update password: \(error)")
            return nil
        }
    }
    
}
