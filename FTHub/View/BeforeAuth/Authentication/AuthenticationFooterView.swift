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
    
    @FetchRequest(sortDescriptors: []) var appVariables: FetchedResults<AppVariables>
    
    var saveDetails: () -> Bool
    
    var body: some View {
        VStack {
            SignUpWithAppleView()
                .padding(.top, 20)
            
            Button(action: {
                if saveDetails() {
                    withAnimation {
                        appVariables[0].buttonLoading = true
                        baseAuthController.authenticateUser()
                    }
                }
            }, label: {
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
}

#Preview {
    AuthenticationFooterView(method: .signIn, name: "Tosho", email: "kokmarok@gmail.com", password: "123Prudni@", confirmPassword: "123Prudni@") {return true}
        .environmentObject(BaseAuthController())
}
