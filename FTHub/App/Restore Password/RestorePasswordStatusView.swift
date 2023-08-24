//
//  RestorePasswordStatusView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 24.08.23.
//

import SwiftUI

enum RestorePasswordStatus: String, Codable, CaseIterable {
    case success, fail
}

struct RestorePasswordStatusView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("showRestorePasswordStatus") private var showRestorePasswordStatus: Bool = false
    @AppStorage("restorePasswordStatus") private var status: RestorePasswordStatus = .success
    
    var body: some View {
        VStack {
            Image(systemName: status == .success ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(status == .success ? K.Gradients.mainGradient : K.Gradients.errorGradient)
                .padding(.bottom, 5)
            VStack(spacing: 15) {
                Text(status == .success ? "Password changed" : "Password was\nnot changed")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text(status == .success ? "You have successfuly changed your password" : "There was an error changing your password. Please try again.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.textGray)
                    .fontWeight(.semibold)
            }
            
            Button(action: {
                Task {
                    if status == .fail {
                        withAnimation {
                            showRestorePasswordStatus = false
                        }
                    } else {
                        withAnimation {                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showRestorePasswordStatus = false
                            }
                        }
                    }
                }
            }, label: {
                Text(status == .success ? "Done" : "Try Again")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: status == .success ? K.Gradients.mainGradient : K.Gradients.errorGradient))
            .padding()
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .padding(.top, 40)
        .onChange(of: scenePhase) { oldValue, newScene in
            if newScene == .background {
                withAnimation(.easeOut) {
                    if status == .success {
                        showRestorePasswordStatus = false
                    }
                }
            }
        }
    }
}

#Preview {
    RestorePasswordStatusView()
}
