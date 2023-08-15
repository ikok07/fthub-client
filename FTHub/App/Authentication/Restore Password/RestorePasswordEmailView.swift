//
//  RestorePasswordEmailView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct RestorePasswordEmailView: View {
    
    @State private var emailSent: Bool = false
    @State private var userEmail: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90)
                
                VStack(spacing: 20) {
                    Text("Restore Password")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Enter your account email to\nreset your password")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.textGray)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                Image("restore1")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.9)
                
                CustomTextFieldView(icon: "envelope", placeholder: "Enter your email", text: $userEmail)
                    .padding(.top)
                
                Spacer()
                VStack(spacing: 15) {
                    Button(action: {
                        withAnimation {
                            emailSent = true
                        }
                    }, label: {
                        Text("Send email")
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    })
                    .buttonStyle(CTAButtonStyle(gradient: K.mainGradient))
                    
                    Text("A code will be sent to your email")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textGray)
                }
                Spacer()
                
            } //: VStack
            .padding()
            .padding(.top, 10)
            .navigationDestination(isPresented: $emailSent) {
                RestorePasswordCodeView()
            }
        }
    }
}

#Preview {
    RestorePasswordEmailView()
}
