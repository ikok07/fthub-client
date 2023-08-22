//
//  RestorePasswordEmailView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct RestorePasswordEmailView: View {
    @EnvironmentObject private var restorePasswordController: RestorePasswordController
    @EnvironmentObject private var messageController: MessageController
    
    @State private var emailSent: Bool = false
    @State private var userEmail: String = ""
    
    func sendMsg() {
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                RestorePasswordHeaderView(headline: "Enter your account email to\nreset your password")
                
                Image("restore1")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.9)
                
                CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", text: $userEmail)
                    .padding(.top)
                
                Spacer()
                VStack(spacing: 15) {
                    Button(action: {
                        restorePasswordController.sendMsg = self.sendMsg
                        restorePasswordController.sendEmail(email: userEmail)
                    }, label: {
                        Text("Send email")
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    })
                    .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
                    
                    Text("A code will be sent to your email")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textGray)
                }
                .padding(.top)
                Spacer()
                
            } //: VStack
            .padding()
            .padding(.top, 10)
        }
    }
}

#Preview {
    RestorePasswordEmailView()
        .environmentObject(RestorePasswordController())
        .environmentObject(MessageController())
}
