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
    
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    
    private let authController = AuthController()
    let email: String
    let password: String?
    let code: Int
    let type: EmailAuthType
    
    func performEmailAuthentication(response: EmailAuthRequest) {
        if response.status == "success" {
            messageController.sendMessage(type: .success, apiMessage: String(localized: "Successful email authentication"))
            userToken = response.token ?? ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                userLoggedIn = true
            }
        } else {
            messageController.sendMessage(type: .error, apiMessage: String(localized: "The entered code is invalid or expired"))
        }
    }
    
    var body: some View {
            VStack {
                Button(action: {
                    if numpadController.fullFields && type == .twofa {
                        Task {
                            let response = await Authentication.authEmail(email: email, code: code, type: .twofa)
                            if let safeResponse = response {
                                performEmailAuthentication(response: safeResponse)
                                numpadController.reset()
                            }
                        }
                    } else if numpadController.fullFields && type == .confirm {
                        Task {
                            let response = await Authentication.authEmail(email: email, code: code, type: .confirm)
                            if let safeResponse = response {
                                performEmailAuthentication(response: safeResponse)
                                numpadController.reset()
                            }
                        }
                    }
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
    CodeAuthFooterView(email: "kokmarok@gmail.com", password: "123Prudni@", code: 123, type: .twofa)
        .environmentObject(MessageController())
        .environmentObject(NumpadController())
}
