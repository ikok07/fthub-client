//
//  CodeInputFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import SwiftUI

struct CodeAuthFooterView: View, CustomMessagePresent {
    @EnvironmentObject var messageController: MessageController
    
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    
    private let authController = AuthController()
    let email: String
    let code: Int
    let type: EmailAuthType
    
    @Binding var fullFields: Bool
    
    func performEmailAuthentication(response: EmailAuthRequest) {
        if response.status == "success" {
            messageController.sendMessage(type: .success, apiMessage: "Successful email authentication")
            userToken = response.token
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                userLoggedIn = true
            }
        } else {
            messageController.sendMessage(type: .error, apiMessage: "The entered code is invalid or expired")
        }
    }
    
    var body: some View {
            VStack {
                Button(action: {
                    if fullFields && type == .twofa {
                        Task {
                            let response = await authController.authEmail(email: email, code: code, type: .twofa)
                            if let safeResponse = response {
                                performEmailAuthentication(response: safeResponse)
                            }
                        }
                    } else if fullFields && type == .confirm {
                        Task {
                            let response = await authController.authEmail(email: email, code: code, type: .confirm)
                            if let safeResponse = response {
                                performEmailAuthentication(response: safeResponse)
                            }
                        }
                    }
                }, label: {
                        Text("Confirm")
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: fullFields ? K.mainGradient : K.grayGradient))
                .animation(.easeOut(duration: 0.2), value: 10)
                .padding()
                
                HStack(spacing: 5) {
                    Text("Didn't receive code?")
                        .foregroundStyle(.gray)
                    Text("Resend now")
                        .foregroundStyle(K.mainGradient)
                        .fontWeight(.semibold)
                }
                .padding(.bottom)
            } //: VStack
    }
}

#Preview {
    CodeAuthFooterView(email: "kokmarok@gmail.com", code: 123, type: .twofa, fullFields: .constant(false))
        .environmentObject(MessageController())
}
