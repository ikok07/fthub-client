//
//  AuthenticationFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct AuthenticationFooterView: View {
    
    @EnvironmentObject private var messageController: MessageController
    @EnvironmentObject private var baseAuthController: BaseAuthController
    
    let method: AuthOption
    let name: String?
    let email: String
    let password: String
    let confirmPassword: String?
    
    @State private var authenticatedDetails: Bool = false
    
    var saveDetails: () -> Bool
    
    var body: some View {
        VStack {
            SignUpWithAppleView()
                .padding(.top, 20)
            
            Button(action: {
                if saveDetails() {
                    baseAuthController.sendBaseAuthMsg = { response in
                        if let safeResponse = response {
                            if safeResponse.status == "success" {
                                messageController.sendMessage(type: .success, message: safeResponse.message)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    authenticatedDetails = true
                                }
                            } else {
                                messageController.sendMessage(type: .error, message: safeResponse.message)
                            }
                        }
                    }
                    baseAuthController.authenticateUser()
                }
            }, label: {
                Text(method == .signIn ? "Sign In" : "Sign Up")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }) //: Button
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
            
        } //: VStack
        .navigationDestination(isPresented: $authenticatedDetails) {
            TwoFaCodeView(email: email, password: password)
        }
    }
}

#Preview {
    AuthenticationFooterView(method: .signIn, name: "Tosho", email: "kokmarok@gmail.com", password: "123Prudni@", confirmPassword: "123Prudni@") {return true}
        .environmentObject(MessageController())
        .environmentObject(BaseAuthController())
}
