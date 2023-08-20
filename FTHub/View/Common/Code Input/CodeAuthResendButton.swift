//
//  CodeAuthResendButton.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import SwiftUI

struct CodeAuthResendButton: View {
    
    @EnvironmentObject var messageController: MessageController
    @EnvironmentObject var numpadController: NumpadController
    
    private let authController = AuthController()
    let email: String
    let password: String?
    let type: EmailAuthType
    
    func sendMessage(status: String, message: String) {
        if status == "success" {
            messageController.sendMessage(type: .success, apiMessage: message)
        } else {
            messageController.sendMessage(type: .error, apiMessage: message)
        }
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Text("Didn't receive code?")
                .foregroundStyle(.gray)
            Button {
                Task {
                    if type == .confirm {
                        let response = await authController.resendAuthCode(email: email)
                        if let safeResponse = response {
                            sendMessage(status: safeResponse.status, message: safeResponse.message)
                        }
                    } else {
                        let response = await authController.signIn(email: email, password: password!)
                        if let safeResponse = response {
                            sendMessage(status: safeResponse.status, message: safeResponse.message)
                        }
                    }
                }
            } label: {
                Text("Resend now")
                    .foregroundStyle(K.Gradients.mainGradient)
                    .fontWeight(.semibold)
            }

        }
        .padding(.bottom, 30)
    }
}

#Preview {
    CodeAuthResendButton(email: "kokmarok@gmail.com", password: "123Prudni@", type: .confirm)
        .environmentObject(MessageController())
        .environmentObject(NumpadController())
}
