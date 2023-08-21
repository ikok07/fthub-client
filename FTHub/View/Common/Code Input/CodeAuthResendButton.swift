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
    @EnvironmentObject var resendController: ResendCodeController

    
    private func sendConfirmMessage(response: ResendAuthCodeResponse?) {
        if let safeResponse = response {
            if safeResponse.status == "success" {
                messageController.sendMessage(type: .success, apiMessage: safeResponse.message)
            } else {
                messageController.sendMessage(type: .error, apiMessage: safeResponse.message)
            }
        }
    }
    
    private func sendTwoFaMessage(response: AccountAuthResponse?) {
        if let safeResponse = response {
            if safeResponse.status == "success" {
                messageController.sendMessage(type: .success, apiMessage: safeResponse.message)
            } else {
                messageController.sendMessage(type: .error, apiMessage: safeResponse.message)
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Text("Didn't receive code?")
                .foregroundStyle(.gray)
            Button {
                resendController.resendCode()
            } label: {
                Text("Resend now")
                    .foregroundStyle(K.Gradients.mainGradient)
                    .fontWeight(.semibold)
            }

        }
        .padding(.bottom, 30)
        .onAppear {
            resendController.sendResendConfirmCodeMsg = { response in
                sendConfirmMessage(response: response)
            }
            resendController.sendResendTwoFaCodeMsg = { response in
                sendTwoFaMessage(response: response)
            }
        }
    }
}

#Preview {
    CodeAuthResendButton()
        .environmentObject(MessageController())
        .environmentObject(NumpadController())
        .environmentObject(ResendCodeController())
}
