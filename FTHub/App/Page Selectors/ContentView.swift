//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool?
    @AppStorage("userToken") private var userToken: String = ""
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @State private var loadContentView: Bool = false
    
    var body: some View {
        ZStack {
            if loadContentView {
                ZStack {
                    if userLoggedIn == true {
                        SetupPageViewManager()
                    } else if userLoggedIn == true {
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
                if let user = user.first {
                    modelContext.delete(user)
                }
                let response = await AccountController.checkToken()
                if let safeResponse = response {
                    modelContext.insert(safeResponse.data!)
                }
                print(user)
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
