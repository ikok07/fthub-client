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
    
    @AppStorage("userCurrentEmail") private var userCurrentEmail: String = ""
    
    @State private var showTwoFa: Bool = false
    @State private var emailNotVerified: Bool = false
    
    var saveDetails: () -> Bool

    func sendMsg(response: AccountAuthResponse?) {
        print(response!.identifier)
        if response != nil {
            
            if response!.status == "fail" && response!.identifier != "EmailNotVerified"{
                messageController.sendMessage(type: .error, message: response!.message)
            } else if response!.identifier == "EmailNotVerified"{
                Task {
                    let emailSentResponse = await Authentication.resendConfirmEmail(email: email)
                    if emailSentResponse != nil && emailSentResponse?.status == "success" {
                        userCurrentEmail = baseAuthController.email ?? "No email saved"
                        print(userCurrentEmail)
                        print("---------")
                        emailNotVerified = true
                    } else {
                        messageController.sendMessage(type: .error, message: "Error connecting to server")
                    }
                }
            } else {
                messageController.sendMessage(type: .success, message: response!.message)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if method == .signIn {
                        showTwoFa = true
                    }
                }
            }
            
        } else {
                messageController.sendMessage(type: .error, message: "Error connecting to server")
        }
    }
    
    
    var body: some View {
        VStack {
            SignUpWithAppleView()
                .padding(.top, 20)
            
            Button(action: {
                if saveDetails() {
                    baseAuthController.sendBaseAuthMsg = sendMsg
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
        .environmentObject(MessageController())
        .environmentObject(BaseAuthController())
}
