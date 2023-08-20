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
    @EnvironmentObject var authController: AuthController

    
    func sendMessage(confirmResponse: ResendAuthCodeResponse? = nil, twoFaResponse: AccountAuthResponse? = nil) {
        if confirmResponse != nil {
            if confirmResponse!.status == "success" {
                messageController.sendMessage(type: .success, apiMessage: confirmResponse!.message)
            } else {
                messageController.sendMessage(type: .error, apiMessage: confirmResponse!.message)
            }
        } else if twoFaResponse != nil {
            if twoFaResponse!.status == "success" {
                messageController.sendMessage(type: .success, apiMessage: twoFaResponse!.message)
            } else {
                messageController.sendMessage(type: .error, apiMessage: twoFaResponse!.message)
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Text("Didn't receive code?")
                .foregroundStyle(.gray)
            Button {
                Task {
                    if authController.type == .confirm {
                        let response = await authController.resendConfirmCode()
                        sendMessage(confirmResponse: response)
                    } else {
                        let response = await authController.resendTwoFaCode()
                        sendMessage(twoFaResponse: response)
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
    CodeAuthResendButton()
        .environmentObject(MessageController())
        .environmentObject(NumpadController())
        .environmentObject(AuthController())
}
