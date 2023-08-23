//
//  AuthenticationFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct AuthenticationFooterView: View {
    
    @EnvironmentObject private var baseAuthController: BaseAuthController
    
    let method: AuthOption
    let name: String?
    let email: String
    let password: String
    let confirmPassword: String?
    
    @AppStorage("showTwoFa") private var showTwoFa: Bool = false
    @AppStorage("emailNotVerified") private var emailNotVerified: Bool = false
    
    var saveDetails: () -> Bool

    func sendMsg(response: AccountAuthResponse?) {
        
    }
    
    
    var body: some View {
        VStack {
            SignUpWithAppleView()
                .padding(.top, 20)
            
            Button(action: {
                if saveDetails() {
                    baseAuthController.authenticateUser()
                }
            }, label: {
                Text(method == .signIn ? "Sign In" : "Sign Up")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }) //: Button
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
            
        } //: VStack
        .navigationDestination(isPresented: $showTwoFa) {
            TwoFaCodeView(email: email, password: password)
        }
        .navigationDestination(isPresented: $emailNotVerified) {
            EmailConfirmationLinkSentView()
        }
    }
}

#Preview {
    AuthenticationFooterView(method: .signIn, name: "Tosho", email: "kokmarok@gmail.com", password: "123Prudni@", confirmPassword: "123Prudni@") {return true}
        .environmentObject(BaseAuthController())
}
