//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool?
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @State private var loadContentView: Bool = false
    
    var body: some View {
        ZStack {
            if loadContentView {
                ZStack {
                    if userLoggedIn == true {
                        CoachesPageView()
                    } else {
                        BeforeAuthView()
                    }
                }
                .withCustomMessage()
                .withLoadingAnimation()
                .sensoryFeedback(.success, trigger: userLoggedIn)
                .animation(.easeOut, value: userLoggedIn)
            } else {
                FakeLaunchScreenView()
            }
        }
        .onAppear {
            Task {
                await AccountController.checkToken()
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
