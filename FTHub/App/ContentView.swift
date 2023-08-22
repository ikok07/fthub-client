//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var messageController: MessageController
    var confirmEmailController: ConfirmEmailController = ConfirmEmailController()
    
    @AppStorage("showTutorial") private var showTutorial: Bool = true
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    @AppStorage("userCurrentEmail") private var userCurrentEmail: String = ""
    
    @State private var confirmedEmail: Bool = false
    
    var body: some View {
        ZStack {
            if self.showTutorial {
                TutorialMainView()
            } else if userLoggedIn {
                CoachesPageView()
            } else if confirmedEmail {
              SuccessfullEmailConfirmationView()
            } else {
                MainAccountAuthView()
            }
        }
        .animation(.easeOut, value: showTutorial)
        .onOpenURL { url in
            if url.absoluteString.contains("email/confirm/") {
                Task {
                    let emailConfirmed = await confirmEmailController.confirmEmail(url: url, email: userCurrentEmail)
                    if emailConfirmed {
                        withAnimation {
                            confirmedEmail = true
                        }
                    } else {
                        messageController.sendMessage(type: .error, message: "We couldn't confirm your email address. Please try again later.")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MessageController())
}
