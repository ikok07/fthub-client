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
    
    @FetchRequest(sortDescriptors: []) var appVariables: FetchedResults<AppVariables>
    
    var body: some View {
        VStack {
            Image(systemName: appVariables[0].restorePasswordStatus == RestorePasswordStatus.success.rawValue ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(appVariables[0].restorePasswordStatus == RestorePasswordStatus.success.rawValue ? K.Gradients.mainGradient : K.Gradients.errorGradient)
                .padding(.bottom, 5)
            VStack(spacing: 15) {
                Text(appVariables[0].restorePasswordStatus == RestorePasswordStatus.success.rawValue ? "Password changed" : "Password was\nnot changed")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text(appVariables[0].restorePasswordStatus == RestorePasswordStatus.success.rawValue ? "You have successfuly changed your password" : "There was an error changing your password. Please try again.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.textGray)
                    .fontWeight(.semibold)
            }
            
            Button(action: {
                withAnimation {
                    if appVariables[0].restorePasswordStatus == RestorePasswordStatus.success.rawValue {
                        appVariables[0].userLoggedIn = true
                    }
                    appVariables[0].showRestorePasswordStatus = false
                }
            }, label: {
                Text(appVariables[0].restorePasswordStatus == RestorePasswordStatus.success.rawValue ? "Done" : "Try Again")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: appVariables[0].restorePasswordStatus == RestorePasswordStatus.success.rawValue ? K.Gradients.mainGradient : K.Gradients.errorGradient))
            .padding()
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .padding(.top, 40)
        .onChange(of: scenePhase) { oldValue, newScene in
            if newScene == .background {
                withAnimation(.easeOut) {
                    appVariables[0].showRestorePasswordStatus = false
                }
            }
        }
    }
}

#Preview {
    RestorePasswordStatusView()
}
