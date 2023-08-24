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

struct TokenConfirmationStatusView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    @AppStorage("userCurrentEmail") private var userCurrentEmail: String = ""
    @AppStorage("emailWithLinkSent") private var emailNotVerified: Bool = false
    @AppStorage("showTokenVerifyStatus") private var showTokenVerifyStatus: Bool = false
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @AppStorage("tokenConfirmationStatus") private var status: TokenVerifyStatus = .success
    
    var body: some View {
        VStack {
            Image(systemName: status == .success ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(status == .success ? K.Gradients.mainGradient : K.Gradients.errorGradient)
                .padding(.bottom, 5)
                .symbolEffect(.bounce.up.byLayer, value: emailNotVerified)
            VStack(spacing: 15) {
                Text("Email \(status == .fail ? "not ": "")verified")
                    .font(.title)
                    .fontWeight(.bold)
                Text(status == .success ? "You have successfuly verified\n your email" : "There was an error verifying your email address. Please try again.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.textGray)
                    .fontWeight(.semibold)
            }
            
            
            VStack {
                Button(action: {
                    Task {
                        if status == .fail {
                            loadingPresented = true
                            await Authentication.sendConfirmEmail(email: userCurrentEmail)
                            withAnimation {
                                emailNotVerified = true
                                showTokenVerifyStatus = false
                            }
                        } else {
                            withAnimation {
                                userLoggedIn = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    showTokenVerifyStatus = false
                                }
                            }
                        }
                    }
                }, label: {
                    Text(status == .success ? "Go to Dashboard" : "Resend Email")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: status == .success ? K.Gradients.mainGradient : K.Gradients.errorGradient))
                .padding()
                .padding(.top, 20)
                
                if status == .fail {
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
                    if status == .success {
                        userLoggedIn = true
                    }
                }
            }
        }
    }
}

#Preview {
    TokenConfirmationStatusView()
}
