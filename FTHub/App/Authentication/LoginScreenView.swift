//
//  LoginScreenView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct LoginScreenView: View {
    
    @State private var activeOption: AuthOption = .signIn
    @State private var signInEmailText: String = ""
    @State private var signInPasswordText: String = ""
    
    @State private var signUpNameText: String = ""
    @State private var signUpEmailText: String = ""
    @State private var signUpPasswordText: String = ""
    @State private var signUpConfirmPasswordText: String = ""
    
    var body: some View {
        ScrollView {
            
            AuthenticationHeaderView(activeOption: $activeOption)
                .padding(.top, 30)
            
            if activeOption == .signIn {
                VStack(spacing: 20) {
                    CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", text: $signInEmailText)
                    CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", text: $signInPasswordText)
                    Button(action: {}, label: {
                        HStack {
                            Text("Forgot password?")
                                .foregroundStyle(.textGray)
                                .fontWeight(.medium)
                                .padding(.leading)
                            Spacer()
                        }
                    })
                } //: VStack
            } else {
                VStack(spacing: 20, content: {
                    CustomTextFieldView(icon: "person.crop.circle", placeholder: "Enter your name", text: $signUpNameText)
                    CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", text: $signUpEmailText)
                    CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", text: $signUpPasswordText)
                    CustomTextFieldView(icon: "key.horizontal", placeholder: "Confirm your password", text: $signUpConfirmPasswordText)
                })
            }
            
            AuthenticationFooterView(method: .signIn)
            
        } //: ScrollView
        .padding(.horizontal)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    LoginScreenView()
}
