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
    
    var body: some View {
        HStack(spacing: 5) {
            Text("Didn't receive code?")
                .foregroundStyle(.gray)
            Button {
                Task {
                    let response = await authController.resendAuthCode(email: email)
                    if let safeResponse = response {
                        if safeResponse.status == "success" {
                            messageController.sendMessage(type: .success, apiMessage: safeResponse.message)
                        } else {
                            messageController.sendMessage(type: .error, apiMessage: safeResponse.message)
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
    CodeAuthResendButton(email: "kokmarok@gmail.com")
        .environmentObject(MessageController())
        .environmentObject(NumpadController())
}
