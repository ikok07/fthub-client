//
//  AuthenticationFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct AuthenticationFooterView: View {
    
    let method: AuthOption
    @State private var authenticatedDetails: Bool = false
    
    var body: some View {
        VStack {
            SignUpWithAppleView()
                .padding(.top, 20)

            
            Button(action: {
                authenticatedDetails = true
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
    AuthenticationFooterView(method: .signIn)
}
