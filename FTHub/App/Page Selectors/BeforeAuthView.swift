//
//  BeforeAuthView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.08.23.
//

import SwiftUI

struct BeforeAuthView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @FetchRequest(sortDescriptors: []) private var variables: FetchedResults<AppVariables>
    
    var body: some View {
        ZStack {
            if self.variables[0].showTutorial {
                TutorialPageViewManager()
            } else if self.variables[0].emailWithLinkSent {
                EmailConfirmationLinkSentView()
            } else if self.variables[0].showTokenVerifyStatus {
                TokenConfirmationStatusView()
            } else if self.variables[0].showRestorePasswordStatus {
                RestorePasswordStatusView()
            } else if self.variables[0].showRestorePassword {
                RestorePasswordMainView()
            } else {
                MainAccountAuthView()
            }
        }
        .animation(.easeOut, value: variables[0].showTutorial)
        .animation(.easeOut, value: variables[0].userCurrentEmail)
        .animation(.easeOut, value: variables[0].loadingPresented)
        .animation(.easeOut, value: variables[0].emailWithLinkSent)
        .animation(.easeOut, value: variables[0].showTokenVerifyStatus)
        .animation(.easeOut, value: variables[0].showRestorePassword)
        .animation(.easeOut, value: variables[0].showRestorePasswordStatus)
        .onOpenURL { url in
            print(url.pathComponents)
            
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                print("Invalid URL")
                return
            }
            
            if components.host == "email" && url.pathComponents[1] == "confirm" {
                variables[0].loadingPresented = true
                Task {
                    await CustomURLController.confirmEmail(url: url)
                }
            } else if components.host == "login" && url.pathComponents[1] == "confirm" {
                variables[0].loadingPresented = true
                Task {
                    await CustomURLController.checkTwoFa(email: self.variables[0].userCurrentEmail ?? "", url: url)
                } 
            } else if url.pathComponents[1] == "reset" {
                variables[0].loadingPresented = true
                Task {
                    await CustomURLController.openResetPassword(url: url)
                }
            }
        }
        .onChange(of: scenePhase) { oldValue, newScene in
            if newScene == .background {
                variables[0].emailWithLinkSent = false
                variables[0].showTokenVerifyStatus = false
            }
        }
    }
}

#Preview {
    BeforeAuthView()
}
