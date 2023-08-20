//
//  SignUpWithAppleView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI
import AuthenticationServices

struct SignUpWithAppleView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 30) {
            Text("or choose another option")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundStyle(.textGray)
            
            SignInWithAppleButton { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("success: \(authResults)")
                case .failure(let error):
                    print("fail: \(error)")
                }
            }
            .padding(.horizontal, 50)
            .frame(height: 44)
            .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

#Preview {
    SignUpWithAppleView()
}
