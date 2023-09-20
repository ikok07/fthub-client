//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool?
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @State private var loadContentView: Bool = false
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        ZStack {
            if loadContentView {
                ZStack {
                    if userLoggedIn == true && !users[0].hasFullDetails {
                        SetupPageViewManager()
                    } else if userLoggedIn == true {
                        MainAppView()
                    } else {
                        BeforeAuthView()
                    }
                }
                .withCustomMessage()
                .withLoadingAnimation()
                .sensoryFeedback(.success, trigger: userLoggedIn)
                .animation(.easeOut, value: userLoggedIn)
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
