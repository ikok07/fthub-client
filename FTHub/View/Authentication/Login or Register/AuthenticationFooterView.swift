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
    let email: String
    let password: String
    let confirmPassword: String? = nil
    
    @State private var authenticatedDetails: Bool = false
    
    func performLoginAuthorisation(response: SignInRequest) {
        print(response)
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
                            performLoginAuthorisation(response: safeResponse)
                        }
                    }
                }
            }, label: {
                Text(method == .signIn ? "Sign In" : "Sign Up")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.mainGradient))
            .padding()
        } //: VStack
        .navigationDestination(isPresented: $authenticatedDetails) {
            ConfirmEmailView()
        }
    }
}

#Preview {
    AuthenticationFooterView(method: .signIn, email: "kokmarok@gmail.com", password: "123Prudni@")
}