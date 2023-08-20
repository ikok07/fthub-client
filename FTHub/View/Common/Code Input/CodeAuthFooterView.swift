//
//  CodeInputFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct CodeAuthFooterView: View, CustomMessagePresent {
    @EnvironmentObject var messageController: MessageController
    @EnvironmentObject var numpadController: NumpadController
    @EnvironmentObject var codeAuthController: CodeAuthController
    
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    
    let email: String
    let code: Int
    let type: EmailAuthType
    
    private func saveData() {
        codeAuthController.type = self.type
        codeAuthController.email = self.email
        codeAuthController.token = self.code
    }
    
    var body: some View {
            VStack {
                Button(action: {
                    saveData()
                    codeAuthController.sendCodeAuthMsg = { response in
                        if let safeResponse = response {
                            if safeResponse.status == "success" {
                                messageController.sendMessage(type: .success, apiMessage: String(localized: "Successful email authentication"))
                                userToken = safeResponse.token ?? ""
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    userLoggedIn = true
                                }
                            } else {
                                messageController.sendMessage(type: .error, apiMessage: String(localized: "The entered code is invalid or expired"))
                            }
                        }
                    }
                    codeAuthController.authenticateCode()
                    
                }, label: {
                        Text("Confirm")
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: numpadController.fullFields ? K.Gradients.mainGradient : K.Gradients.grayGradient))
                .animation(.easeOut(duration: 0.2), value: 10)
                .padding()
                
                CodeAuthResendButton() 
                .padding(.bottom, 30)
                
                CustomNumpadView()
            } //: VStack
            .onDisappear {
                numpadController.reset()
            }
    }
}

#Preview {
    CodeAuthFooterView(email: "kokmarok@gmail.com", code: 123, type: .twofa)
        .environmentObject(MessageController())
        .environmentObject(NumpadController())
        .environmentObject(CodeAuthController())
}
