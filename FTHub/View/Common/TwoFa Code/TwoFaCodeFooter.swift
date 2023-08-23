//
//  CodeInputFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct TwoFaCodeFooter: View {
    @EnvironmentObject var numpadController: NumpadController
    @EnvironmentObject var codeAuthController: TwoFaAuthController
    
    let email: String
    let code: Int
    
    private func saveData() {
        codeAuthController.email = self.email
        codeAuthController.token = self.code
    }
    
    private func performAuthentication() {
        saveData()
        codeAuthController.authenticateCode()
    }
    
    var body: some View {
            VStack {
                Button(action: {
                    performAuthentication()
                }, label: {
                        Text("Confirm")
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: numpadController.fullFields ? K.Gradients.mainGradient : K.Gradients.grayGradient))
                .animation(.easeOut(duration: 0.2), value: 10)
                .padding()
                
                TwoFaCodeResendButton() 
                .padding(.bottom, 30)
                
                CustomNumpadView()
            } //: VStack
            .onDisappear {
                numpadController.reset()
            }
    }
}

#Preview {
    TwoFaCodeFooter(email: "kokmarok@gmail.com", code: 123)
        .environmentObject(NumpadController())
        .environmentObject(TwoFaAuthController())
}
