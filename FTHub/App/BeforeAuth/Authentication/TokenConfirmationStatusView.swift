//
//  EmailConfirmationStatusView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import SwiftUI

enum TokenVerifyStatus: String, Codable, CaseIterable {
    case success, fail
}

enum SendEmailType: String, Codable, CaseIterable {
    case twoFa, confirm
}

struct TokenConfirmationStatusView: View {
    
    @Environment(\.scenePhase) var scenePhase
    @Environment(BaseAuthController.self) var baseAuthController
    
    @FetchRequest(sortDescriptors: []) private var variables: FetchedResults<AppVariables>
    
    var body: some View {
        VStack {
            Image(systemName: variables[0].tokenConfirmationStatus == TokenVerifyStatus.success.rawValue ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(variables[0].tokenConfirmationStatus == TokenVerifyStatus.success.rawValue ? K.Gradients.mainGradient : K.Gradients.errorGradient)
                .padding(.bottom, 5)
                .symbolEffect(.bounce.up.byLayer, value: variables[0].emailWithLinkSent)
            VStack(spacing: 15) {
                Text("Email \(variables[0].tokenConfirmationStatus == TokenVerifyStatus.fail.rawValue ? "not ": "")approved")
                    .font(.title)
                    .fontWeight(.bold)
                Text(variables[0].tokenConfirmationStatus == TokenVerifyStatus.success.rawValue ? "You have successfuly approved\n your email" : "There was an error approving your email address. Please try again.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.textGray)
                    .fontWeight(.semibold)
            }
            
            
            VStack {
                Button(action: {
                    Task {
                        if variables[0].tokenConfirmationStatus == TokenVerifyStatus.fail.rawValue {
                            variables[0].loadingPresented = true
                            baseAuthController.activeOption = .signIn
                            baseAuthController.authenticateUser()
                        } else {
                            withAnimation {
                                variables[0].userLoggedIn = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    variables[0].showTokenVerifyStatus = false
                                }
                                DB.shared.saveContext()
                            }
                        }
                    }
                }, label: {
                    Text(variables[0].tokenConfirmationStatus == TokenVerifyStatus.success.rawValue ? "Continue" : "Try again")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: variables[0].tokenConfirmationStatus == TokenVerifyStatus.success.rawValue ? K.Gradients.mainGradient : K.Gradients.errorGradient))
                .padding()
                .padding(.top, 20)
                
                if variables[0].tokenConfirmationStatus == TokenVerifyStatus.fail.rawValue {
                    Button(action: {}, label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.customDarkRed)
                        Text("Return to sign in")
                            .foregroundStyle(.customDarkRed)
                    })
                }
            }
            
            Spacer()
        }
        .padding()
        .padding(.top, 40)
        .onChange(of: scenePhase) { oldValue, newScene in
            if newScene == .background {
                withAnimation(.easeOut) {
                    if variables[0].tokenConfirmationStatus == TokenVerifyStatus.success.rawValue {
                        variables[0].userLoggedIn = true
                        DB.shared.saveContext()
                    }
                }
            }
        }
    }
}

#Preview {
    TokenConfirmationStatusView()
}
