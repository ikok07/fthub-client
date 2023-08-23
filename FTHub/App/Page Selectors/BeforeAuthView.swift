//
//  BeforeAuthView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.08.23.
//

import SwiftUI


struct BeforeAuthView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    var confirmEmailController: ConfirmEmailController = ConfirmEmailController()
    
    @AppStorage("showTutorial") private var showTutorial: Bool = true
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    @AppStorage("userCurrentEmail") private var userCurrentEmail: String = ""
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @AppStorage("emailNotVerified") private var emailNotVerified: Bool = false
    @AppStorage("showEmailVerifyStatus") private var showEmailVerifyStatus: Bool = false
    @State private var emailConfirmationStatus: EmailConfirmStatus = .success
    
    var body: some View {
        ZStack {
            if self.showTutorial {
                TutorialMainView()
            } else if self.emailNotVerified {
                EmailConfirmationLinkSentView()
            } else if self.showEmailVerifyStatus {
                EmailConfirmationStatusView(status: emailConfirmationStatus)
            } else {
                MainAccountAuthView()
            }
        }
        .animation(.easeOut, value: showTutorial)
        .animation(.easeOut, value: userCurrentEmail)
        .animation(.easeOut, value: loadingPresented)
        .animation(.easeOut, value: emailNotVerified)
        .animation(.easeOut, value: showEmailVerifyStatus)
        .onOpenURL { url in
            loadingPresented = true
            if url.absoluteString.contains("email/confirm/") {
                Task {
                    let emailConfirmed = await confirmEmailController.confirmEmail(url: url, email: userCurrentEmail)
                    loadingPresented = false
                    if emailConfirmed {
                        emailConfirmationStatus = .success
                        print("success")
                        emailNotVerified = false
                        showEmailVerifyStatus = true
                    } else {
                        emailConfirmationStatus = .fail
                        print("error")
                        emailNotVerified = false
                        showEmailVerifyStatus = true
                    }
                }
            }
        }
        .onChange(of: scenePhase) { oldValue, newScene in
            if newScene == .background {
                    emailNotVerified = false
                    showEmailVerifyStatus = false
            }
        }
    }
}

#Preview {
    BeforeAuthView()
}
