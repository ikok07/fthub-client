//
//  SettingsChangePasswordView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 8.09.23.
//

import SwiftUI

struct SettingsChangePasswordView: View {
    
    @AppStorage("userToken") private var userToken: String = ""
    
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 20) {
                    CustomTextFieldView(icon: "key.horizontal", placeholder: "Current password", autoCapitalize: false, secureField: true, disableAutoCorrect: true, type: .none, text: $currentPassword)
                    
                    CustomTextFieldView(icon: "key.horizontal", placeholder: "New password", autoCapitalize: false, secureField: true, disableAutoCorrect: true, type: .password, text: $newPassword)
                    
                    CustomTextFieldView(icon: "key.horizontal", placeholder: "Confirm new password", autoCapitalize: false, secureField: true, disableAutoCorrect: true, type: .password, text: $confirmPassword)
                }
                
                Spacer()
                
                Button(action: changePassword) {
                       Text("Change password")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))

            }
            .navigationTitle("Change Password")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
    }
    
    func changePassword() {
        Task {
            if newPassword == confirmPassword {
                await SettingsChangePasswordController.changePassword(currPass: self.currentPassword, newPass: self.newPassword, confirmNewPass: self.confirmPassword) { response in
                    if response.status == "success" {
                        userToken = response.token ?? ""
                        Message.send(type: "success", message: response.message ?? "Successfully changed password")
                    } else {
                        Message.send(type: "error", message: response.message ?? "Your password could not be changed at the moment")
                    }
                }
            } else {
                Message.send(type: "error", message: "Your password and confirmation password do not match.")
            }
        }
    }
}

#Preview {
    SettingsChangePasswordView()
        .padding()
}
