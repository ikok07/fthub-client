//
//  LoginScreenView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct MainAccountAuthView: View {
    
    @State private var activeOption: AuthOption = .signIn
    @State private var signInEmailText: String = ""
    @State private var signInPasswordText: String = ""
    
    @State private var signUpNameText: String = ""
    @State private var signUpEmailText: String = ""
    @State private var signUpPasswordText: String = ""
    @State private var signUpConfirmPasswordText: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                AuthenticationHeaderView(activeOption: $activeOption)
                    .padding(.top, 30)
                
                if activeOption == .signIn {
                    VStack(spacing: 20) {
                        CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", autoCapitalize: false, text: $signInEmailText)
                        CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", secureField: true,  text: $signInPasswordText)
                            NavigationLink(destination: RestorePasswordEmailView()) {
                                HStack {
                                    Text("Forgot password?")
                                        .foregroundStyle(.textGray)
                                        .fontWeight(.medium)
                                        .padding(.leading)
                                    Spacer()
                                }
                            }
                    } //: VStack
                } else {
                    VStack(spacing: 20, content: {
                        CustomTextFieldView(icon: "person.crop.circle", placeholder: "Enter your name", text: $signUpNameText)
                        CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", text: $signUpEmailText)
                        CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", text: $signUpPasswordText)
                        CustomTextFieldView(icon: "key.horizontal", placeholder: "Confirm your password", text: $signUpConfirmPasswordText)
                    })
                }
                
                AuthenticationFooterView(method: .signIn, email: signInEmailText, password: signInPasswordText)
            } //: ScrollView
            .padding(.horizontal)
            .scrollIndicators(.hidden)
        } //: NavigationView
    }
}

#Preview {
    MainAccountAuthView()
}
