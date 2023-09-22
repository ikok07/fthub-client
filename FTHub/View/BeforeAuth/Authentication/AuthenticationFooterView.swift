//
//  AuthenticationFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct AuthenticationFooterView: View {
    
    @Environment(BaseAuthController.self) var baseAuthController
    @FetchRequest(sortDescriptors: []) var appVariables: FetchedResults<AppVariables>
    
    let method: AuthOption
    let name: String?
    let email: String
    let password: String
    let confirmPassword: String?

    var body: some View {
        VStack {
            SignUpWithAppleView()
                .padding(.top, 20)
            
            Button(action: authenticate, label: {
                if appVariables[0].buttonLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                } else {
                    Text(method == .signIn ? "Sign In" : "Sign Up")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
            }) //: Button
            .buttonStyle(CTAButtonStyle(gradient: appVariables[0].buttonLoading ? K.Gradients.grayGradient : K.Gradients.mainGradient))
            .disabled(appVariables[0].buttonLoading)
            .animation(.easeOut, value: appVariables[0].buttonLoading)
            .padding()
            
        } //: VStack
        .onAppear {
            appVariables[0].buttonLoading = false
        }
    }
    
    func authenticate() {
        if let message = method == .signUp ? SignUpValidationController.validate(name: self.name ?? "", email: self.email, password: self.password, confirmPassword: self.confirmPassword ?? "") : SignInValidationController.validate(email: self.email, password: self.password) {
            Message.send(type: "error", message: message)
        } else {
            withAnimation {
                appVariables[0].buttonLoading = true
                baseAuthController.saveDetails(activeOption: self.method, name: self.name, email: self.email, password: self.password, confirmPassword: self.confirmPassword)
                baseAuthController.authenticateUser()
            }
        }
    }
}

#Preview {
    AuthenticationFooterView(method: .signIn, name: "Tosho", email: "kokmarok@gmail.com", password: "123Prudni@", confirmPassword: "123Prudni@")
}
