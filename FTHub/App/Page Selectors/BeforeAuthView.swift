//
//  BeforeAuthView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.08.23.
//

import SwiftUI


struct BeforeAuthView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage("showTutorial") private var showTutorial: Bool = true
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    @AppStorage("userCurrentEmail") private var userCurrentEmail: String = ""
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @AppStorage("emailWithLinkSent") private var emailWithLinkSent: Bool = false
    @AppStorage("showEmailVerifyStatus") private var showEmailVerifyStatus: Bool = false
    @AppStorage("showRestorePassword") private var showRestorePassword: Bool = false
    @AppStorage("emailConfirmationStatus") private var emailConfirmationStatus: EmailConfirmStatus = .success
    
    var body: some View {
        ZStack {
            if self.showTutorial {
                TutorialMainView()
            } else if self.emailWithLinkSent {
                EmailConfirmationLinkSentView()
            } else if self.showEmailVerifyStatus {
                EmailConfirmationStatusView()
            } else if self.showRestorePassword {
                RestorePasswordMainView()
            } else {
                MainAccountAuthView()
            }
        }
        .animation(.easeOut, value: showTutorial)
        .animation(.easeOut, value: userCurrentEmail)
        .animation(.easeOut, value: loadingPresented)
        .animation(.easeOut, value: emailWithLinkSent)
        .animation(.easeOut, value: showEmailVerifyStatus)
        .animation(.easeOut, value: showRestorePassword)
        .onOpenURL { url in
            loadingPresented = true
            print(url.pathComponents)
            if url.pathComponents[1] == "confirm" {
                Task {
                    await CustomURLController.confirmEmail(url: url)
                }
            } else if url.pathComponents[1] == "reset" {
                Task {
                    await CustomURLController.openResetPassword()
                }
            }
        }
        .onChange(of: scenePhase) { oldValue, newScene in
            if newScene == .background {
                    emailWithLinkSent = false
                    showEmailVerifyStatus = false
            }
        }
    }
}

#Preview {
    BeforeAuthView()
}
