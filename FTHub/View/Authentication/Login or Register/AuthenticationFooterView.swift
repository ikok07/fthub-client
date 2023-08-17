//
//  AuthenticationFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct AuthenticationFooterView: View {
    
    @EnvironmentObject private var messageController: MessageController
    
    private let authController = AuthController()
    
    let method: AuthOption
    let name: String?
    let email: String
    let password: String
    let confirmPassword: String?
    
    @State private var authenticatedDetails: Bool = false
    
    func performAccountAuthorization(response: AccountAuthResponse) {
        if response.status == "success" {
            messageController.sendMessage(type: .success, apiMessage: response.message)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                authenticatedDetails = true
            }
        } else {
            messageController.sendMessage(type: .error, apiMessage: response.message)
        }
    }
    
    var body: some View {
        VStack {
            SignUpWithAppleView()
                .padding(.top, 20)

            
            Button(action: {
                if method == .signIn {
                    Task {
                        let response = await authController.signIn(email: email, password: password)
                        if let safeResponse = response {
                            performAccountAuthorization(response: safeResponse)
                        }
                    }
                } else if method == .signUp && name != nil && confirmPassword != nil {
                    Task {
                        let response = await authController.signUp(name: name!, email: email, password: password, passwordConfirm: confirmPassword!)
                        if let safeResponse = response {
                            performAccountAuthorization(response: safeResponse)
                        }
                    }
                }
            }, label: {
                Text(method == .signIn ? "Sign In" : "Sign Up")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }) //: Button
            .buttonStyle(CTAButtonStyle(gradient: K.mainGradient))
            .padding()
            
        } //: VStack
        .navigationDestination(isPresented: $authenticatedDetails) {
            ConfirmEmailView(type: method == .signIn ? .twofa : .confirm, email: email)
        }
    }
}

#Preview {
    AuthenticationFooterView(method: .signIn, name: "Tosho", email: "kokmarok@gmail.com", password: "123Prudni@", confirmPassword: "123Prudni@")
        .environmentObject(MessageController())
}
