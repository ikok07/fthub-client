//
//  RestorePasswordMainView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import SwiftUI

struct RestorePasswordMainView: View {
    
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack {
            RestorePasswordHeaderView(headline: "Enter your email\n to reset your password")
            
            VStack(spacing: 20) {
                CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter new password", text: $password)
                
                CustomTextFieldView(icon: "key.horizontal", placeholder: "Confirm new password", text: $confirmPassword)
            }
            .padding(.vertical, 50)
            
            Button(action: {}, label: {
                Text("Create new password")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            Spacer()
        }
        .padding()
        .padding(.top, 10)
    }
}

#Preview {
    RestorePasswordMainView()
}
