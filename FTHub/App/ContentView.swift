//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct ContentView: View {
    
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
            } else if self.userLoggedIn {
                CoachesPageView()
            } else if self.emailNotVerified {
                EmailConfirmationLinkSentView()
            } else if self.showEmailVerifyStatus {
                EmailConfirmationStatusView(status: emailConfirmationStatus)
            } else {
                MainAccountAuthView()
            }
            
            if loadingPresented {
                
            }
        }
        .animation(.easeOut, value: showTutorial)
        .onOpenURL { url in
            loadingPresented = true
            if url.absoluteString.contains("email/confirm/") {
                Task {
                    withAnimation {
                        loadingPresented = false
                    }
                    let emailConfirmed = await confirmEmailController.confirmEmail(url: url, email: userCurrentEmail)
                    if emailConfirmed {
                        emailConfirmationStatus = .success
                        print("success")
                        withAnimation {
                        emailNotVerified = false
                        showEmailVerifyStatus = true
                        }
                    } else {
                        emailConfirmationStatus = .fail
                        print("error")
                        withAnimation {
                        emailNotVerified = false
                        showEmailVerifyStatus = true
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
