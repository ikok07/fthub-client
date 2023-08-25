//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var accountController: AccountController
    
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool?
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    
    var body: some View {
        ZStack {
            ZStack {
                if userLoggedIn == true {
                    CoachesPageView()
                        .animation(.easeOut, value: userLoggedIn)
                } else {
                    BeforeAuthView()
                }
            }
            .withCustomMessage()
            .withLoadingAnimation()
        }
        .onAppear {
            Task {
                loadingPresented = true
                await accountController.checkToken(userToken)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AccountController())
}
