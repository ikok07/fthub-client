//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var loadContentView: Bool = false
    
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    @FetchRequest(sortDescriptors: []) var appVariables: FetchedResults<AppVariables>
    
    
    var body: some View {
        ZStack {
            if loadContentView {
                ZStack {
                    if appVariables[0].userLoggedIn && !users[0].hasFullDetails {
                        SetupPageViewManager()
                    } else if appVariables[0].userLoggedIn {
                        MainAppView()
                    } else {
                        BeforeAuthView()
                    }
                }
                .withCustomMessage()
                .withLoadingAnimation()
                .sensoryFeedback(.success, trigger: appVariables[0].userLoggedIn)
                .animation(.easeOut, value: appVariables[0].userLoggedIn)
//                .animation(.easeOut, value: users[0].hasFullDetails)
            } else {
                FakeLaunchScreenView()
            }
        }
        .onAppear {
            Task {
                await DbUserAuth.checkToken()
                withAnimation {
                    loadContentView = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
