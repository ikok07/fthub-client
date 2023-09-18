//
//  LoginScreenView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct MainAccountAuthView: View {
    @EnvironmentObject private var resendController: ResendCodeController
    @EnvironmentObject private var baseAuthController: BaseAuthController
    
    
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
                ScrollViewReader { scrollValue in
                    ScrollView {
                        AuthenticationHeaderView(activeOption: $activeOption)
                            .padding(.top, 30)
                        
                        if activeOption == .signIn {
                            VStack(spacing: 16) {
                                CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", autoCapitalize: false, disableAutoCorrect: true, type: .email, text: $signInEmailText)
                                
                                CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", secureField: true, type: nil, text: $signInPasswordText)
                                    .id(0)
                                
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
                            VStack(spacing: 16, content: {
                                CustomTextFieldView(icon: "person.crop.circle", placeholder: "Enter your name", disableAutoCorrect: true, type: .name, text: $signUpNameText)
                                    .id(1)
                                CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", autoCapitalize: false, disableAutoCorrect: true, type: .email, text: $signUpEmailText)
                                CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", secureField: true, type: .password, text: $signUpPasswordText)
                                CustomTextFieldView(icon: "key.horizontal", placeholder: "Confirm your password", secureField: true, type: .confirmPassword, text: $signUpConfirmPasswordText)
                            })
                        }
                        AuthenticationFooterView(method: activeOption, name: nil, email: activeOption == .signIn ? signInEmailText : signUpEmailText, password: signInPasswordText, confirmPassword: nil) 
                        {
                            if let message = activeOption == .signUp ? SignUpValidationController.validate(name: self.signUpNameText, email: self.signUpEmailText, password: self.signUpPasswordText, confirmPassword: self.signUpConfirmPasswordText) : SignInValidationController.validate(email: self.signInEmailText, password: self.signInPasswordText) {
                                
                                Message.send(type: "error", message: message)
                                
                                return false
                            } else {
                                resendController.saveData(type: self.activeOption, email: self.signInEmailText, password: self.signInPasswordText)

                                baseAuthController.saveData(activeOption: self.activeOption, name: self.signUpNameText, email: activeOption == .signIn ? self.signInEmailText : self.signUpEmailText, password: activeOption == .signIn ? self.signInPasswordText : self.signUpPasswordText, confirmPassword: signUpConfirmPasswordText)
                                
                                return true
                            }
                        }

                    } //: ScrollView
                    .padding(.horizontal)
                    .scrollIndicators(.hidden)
                    .onAppear {
                        self.signInEmailText = ""
                        self.signInPasswordText = ""
                        self.signUpNameText = ""
                        self.signUpEmailText = ""
                        self.signUpPasswordText = ""
                        self.signUpConfirmPasswordText = ""
                    }
                } //: ScrollViewReader
            } //: NavigationView
        } //: ZStack
    }
}

#Preview {
    MainAccountAuthView()
        .environmentObject(ResendCodeController())
}
