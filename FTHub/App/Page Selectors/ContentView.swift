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
    
    init() {
        Task {
            await AccountController.checkToken()
        }
    }
    
    var body: some View {
        ZStack {
            if loadContentView {
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
                .sensoryFeedback(.success, trigger: userLoggedIn)
            } else {
                FakeLaunchScreenView()
            }
        }
        .onAppear {
            withAnimation {
                loadContentView = true
            }
        }
    }
}

#Preview {
    ContentView()
}
