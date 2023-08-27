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
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @AppStorage("buttonLoading") private var buttonLoading: Bool = false
    
    var saveDetails: () -> Bool
    
    var body: some View {
        VStack {
            SignUpWithAppleView()
                .padding(.top, 20)
            
            Button(action: {
                if saveDetails() {
                    withAnimation {
                        buttonLoading = true
                        baseAuthController.authenticateUser()
                    }
                }
            }, label: {
                if buttonLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                } else {
                    Text(method == .signIn ? "Sign In" : "Sign Up")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
            }) //: Button
            .buttonStyle(CTAButtonStyle(gradient: buttonLoading ? K.Gradients.grayGradient : K.Gradients.mainGradient))
            .disabled(buttonLoading)
            .animation(.easeOut, value: buttonLoading)
            .padding()
            
        } //: VStack
        .navigationDestination(isPresented: $showTwoFa) {
            TwoFaCodeView(email: email, password: password)
        }
        .onAppear {
            buttonLoading = false
        }
    }
}

#Preview {
    AuthenticationFooterView(method: .signIn, name: "Tosho", email: "kokmarok@gmail.com", password: "123Prudni@", confirmPassword: "123Prudni@") {return true}
        .environmentObject(BaseAuthController())
}
