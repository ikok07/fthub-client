//
//  LoginScreenView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct MainAccountAuthView: View, CustomMessagePresent {
    @EnvironmentObject internal var messageController: MessageController
    
    @State private var activeOption: AuthOption = .signIn
    @State private var signInEmailText: String = ""
    @State private var signInPasswordText: String = ""
    
    @State private var signUpNameText: String = ""
    @State private var signUpEmailText: String = ""
    @State private var signUpPasswordText: String = ""
    @State private var signUpConfirmPasswordText: String = ""
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    AuthenticationHeaderView(activeOption: $activeOption)
                        .padding(.top, 30)
                    
                    if activeOption == .signIn {
                        VStack(spacing: 20) {
                            CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", autoCapitalize: false, text: $signInEmailText)
                            CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", secureField: true,  text: $signInPasswordText)
                            HStack {
                                NavigationLink(destination: RestorePasswordEmailView()) {
                                    Text("Forgot password?")
                                        .foregroundStyle(.textGray)
                                        .fontWeight(.medium)
                                        .padding(.leading)
                                }
                                Spacer()
                            }
                        } //: VStack
                    } else {
                        VStack(spacing: 20, content: {
                            CustomTextFieldView(icon: "person.crop.circle", placeholder: "Enter your name", text: $signUpNameText)
                            CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", autoCapitalize: false, text: $signUpEmailText)
                            CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", secureField: true, text: $signUpPasswordText)
                            CustomTextFieldView(icon: "key.horizontal", placeholder: "Confirm your password", secureField: true, text: $signUpConfirmPasswordText)
                        })
                    }
                    
                    if activeOption == .signIn {
                        AuthenticationFooterView(method: activeOption, name: nil, email: signInEmailText, password: signInPasswordText, confirmPassword: nil)
                    } else {
                        AuthenticationFooterView(method: activeOption, name: signUpNameText, email: signUpEmailText, password: signUpPasswordText, confirmPassword: signUpConfirmPasswordText)
                    }
                } //: ScrollView
                .padding(.horizontal)
                .scrollIndicators(.hidden)
            } //: NavigationView
            .withCustomMessage(controller: messageController)
        } //: ZStack
    }
}

#Preview {
    MainAccountAuthView()
        .environmentObject(MessageController())
}
