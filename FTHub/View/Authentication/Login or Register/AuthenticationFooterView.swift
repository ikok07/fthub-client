//
//  AuthenticationFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct AuthenticationFooterView: View {
    
    private let authController = AuthController()
    
    let method: AuthOption
    let name: String?
    let email: String
    let password: String
    let confirmPassword: String?
    
    @State private var authenticatedDetails: Bool = false
    
    func performLoginAuthorization(response: SignInResponse) {
        if response.status == "success" {
            authenticatedDetails = true
        } else {
            print("Details not valid: \(response.message)")
        }
    }
    
    func performSignUp(response: SignUpResponse) {
        print(response)
        if response.status == "success" {
            authenticatedDetails = true
        } else {
            print("Could not register account")
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
                            performLoginAuthorization(response: safeResponse)
                        }
                    }
                } else if method == .signUp && name != nil && confirmPassword != nil {
                    Task {
                        let response = await authController.signUp(name: name!, email: email, password: password, passwordConfirm: confirmPassword!)
                        if let safeResponse = response {
                            performSignUp(response: safeResponse)
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
}
