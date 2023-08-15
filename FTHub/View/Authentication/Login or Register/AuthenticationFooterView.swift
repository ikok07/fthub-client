//
//  AuthenticationFooterView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct AuthenticationFooterView: View {
    
    let method: AuthOption
    
    var body: some View {
        VStack {
            SignUpWithAppleView()
                .padding(.top, 20)

            
            Button(action: {}, label: {
                Text(method == .signIn ? "Sign In" : "Sign Up")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.mainGradient))
            .padding()
        } //: VStack
    }
}

#Preview {
    AuthenticationFooterView(method: .signIn)
}
