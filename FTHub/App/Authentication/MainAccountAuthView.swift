//
//  LoginScreenView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct MainAccountAuthView: View, CustomMessagePresent {
    @EnvironmentObject internal var messageController: MessageController
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
                ScrollView {
                    AuthenticationHeaderView(activeOption: $activeOption)
                        .padding(.top, 30)
                    
                    if activeOption == .signIn {
                        VStack(spacing: 16) {
                            CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", autoCapitalize: false, type: .email, text: $signInEmailText)
                            CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", secureField: true, type: .password, text: $signInPasswordText)
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
                            CustomTextFieldView(icon: "person.crop.circle", placeholder: "Enter your name", type: .name, text: $signUpNameText)
                            CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", autoCapitalize: false, type: .email, text: $signUpEmailText)
                            CustomTextFieldView(icon: "key.horizontal", placeholder: "Enter your password", secureField: true, type: .password, text: $signUpPasswordText)
                            CustomTextFieldView(icon: "key.horizontal", placeholder: "Confirm your password", secureField: true, type: .confirmPassword, text: $signUpConfirmPasswordText)
                        })
                    }
                    AuthenticationFooterView(method: activeOption, name: nil, email: activeOption == .signIn ? signInEmailText : signUpEmailText, password: signInPasswordText, confirmPassword: nil) 
                    {
                        if let message = activeOption == .signUp ? SignUpValidationController.validate(name: self.signUpNameText, email: self.signUpEmailText, password: self.signUpPasswordText, confirmPassword: self.signUpConfirmPasswordText) : SignInValidationController.validate(email: self.signInEmailText, password: self.signInPasswordText) {
                            
                            messageController.sendMessage(type: .error, message: message)
                            
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
            } //: NavigationView
            .withCustomMessage(controller: messageController)
        } //: ZStack
    }
}

#Preview {
    MainAccountAuthView()
        .environmentObject(MessageController())
        .environmentObject(ResendCodeController())
}
