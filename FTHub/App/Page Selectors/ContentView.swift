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
    @AppStorage("hasDetails") private var hasDetails: Bool = false
    
    var body: some View {
        ZStack {
            if loadContentView {
                ZStack {
                    if userLoggedIn == true && !hasDetails {
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
                .animation(.easeOut, value: hasDetails)
            } else {
                FakeLaunchScreenView()
            }
        }
        .onAppear {
            Task {
                if await DbUserAuth.checkToken() {
                    hasDetails = await DbUserAuth.checkDetails()
                }
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
