//
//  BeforeAuthView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.08.23.
//

import SwiftUI
import SwiftData


struct BeforeAuthView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject private var baseAuthController: BaseAuthController
    
    @AppStorage("showTutorial") private var showTutorial: Bool = true
    @AppStorage("userCurrentEmail") private var userCurrentEmail: String = ""
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @AppStorage("showRestorePasswordStatus") private var showRestorePasswordStatus: Bool = false
    @AppStorage("emailWithLinkSent") private var emailWithLinkSent: Bool = false
    @AppStorage("showTokenVerifyStatus") private var showTokenVerifyStatus: Bool = false
    @AppStorage("showRestorePassword") private var showRestorePassword: Bool = false
    @AppStorage("tokenConfirmationStatus") private var tokenConfirmationStatus: TokenVerifyStatus = .success
    
    @Query private var user: [User]
    
    var body: some View {
        ZStack {
            if self.showTutorial {
                TutorialPageViewManager()
            } else if self.emailWithLinkSent {
                EmailConfirmationLinkSentView()
            } else if self.showTokenVerifyStatus {
                TokenConfirmationStatusView()
            } else if self.showRestorePasswordStatus {
                RestorePasswordStatusView()
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
        .animation(.easeOut, value: showTokenVerifyStatus)
        .animation(.easeOut, value: showRestorePassword)
        .animation(.easeOut, value: showRestorePasswordStatus)
        .onOpenURL { url in
            print(url.pathComponents)
            
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                print("Invalid URL")
                return
            }
            
            if components.host == "email" && url.pathComponents[1] == "confirm" {
                loadingPresented = true
                Task {
                    await CustomURLController.confirmEmail(url: url) { user in
                        if let user = user {
                            user.details = UserDetails(setupActivePage: 0)
                            modelContext.insert(user)
                        }
                    }
                }
            } else if components.host == "login" && url.pathComponents[1] == "confirm" {
                loadingPresented = true
                
                if baseAuthController.activeOption != nil {
                    Task {
                        await CustomURLController.checkTwoFa(email: self.userCurrentEmail, url: url) { newUser in
                            let details = await AccountController.checkDetails()
                            if let userDetails = details, let safeUser = newUser {
                                if let user = user.first {
                                    modelContext.delete(user)
                                }
                                newUser?.details = userDetails
                                modelContext.insert(safeUser)
                            }
                        }
                    }
                } else {
                    showTokenVerifyStatus = false
                    emailWithLinkSent = false
                    loadingPresented = false
                }
                
            } else if url.pathComponents[1] == "reset" {
                loadingPresented = true
                Task {
                    await CustomURLController.openResetPassword(url: url)
                }
            }
        }
        .onChange(of: scenePhase) { oldValue, newScene in
            if newScene == .background {
                    emailWithLinkSent = false
                    showTokenVerifyStatus = false
            }
        }
    }
}

#Preview {
    BeforeAuthView()
        .environmentObject(BaseAuthController())
}
