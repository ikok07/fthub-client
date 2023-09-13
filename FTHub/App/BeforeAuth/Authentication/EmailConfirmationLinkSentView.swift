//
//  RestorePasswordEmailSentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import SwiftUI

struct EmailConfirmationLinkSentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("emailWithLinkSent") private var emailNotVerified: Bool = false
    @AppStorage("showTokenVerifyStatus") private var showEmailVerifyStatus: Bool = false
    @AppStorage("userCurrentEmail") private var userCurrentEmail: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Image("restore2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                VStack {
                    Text("We have sent a link to")
                    Text(userCurrentEmail)
                        .tint(.text)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
            
            VStack(spacing: 20) {
                Button(action: {
                    UIApplication.shared.open(URL(string: "message://")!)
                }, label: {
                    Text("Open Mail")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
                
                Button {
                    withAnimation {
                        emailNotVerified = false
                        showEmailVerifyStatus = false
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back to sign in")
                            .fontWeight(.semibold)
                    }
                }

            }
            .padding(.vertical, 50)
        }
        .padding()
        .onChange(of: scenePhase) { oldValue, newScene in
            if newScene == .background {
                withAnimation(.easeOut) {
                    emailNotVerified = false
                    showEmailVerifyStatus = false
                }
            }
        }
    }
}

#Preview {
    EmailConfirmationLinkSentView()
}
