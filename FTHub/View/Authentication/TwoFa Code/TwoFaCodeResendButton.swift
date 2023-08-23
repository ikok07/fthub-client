//
//  CodeAuthResendButton.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import SwiftUI

struct TwoFaCodeResendButton: View {
    
    @EnvironmentObject var numpadController: NumpadController
    @EnvironmentObject var resendController: ResendCodeController

    
    private func sendTwoFaMessage(response: AccountAuthResponse?) {
        
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
    }
}

#Preview {
    TwoFaCodeResendButton()
        .environmentObject(NumpadController())
        .environmentObject(ResendCodeController())
}
