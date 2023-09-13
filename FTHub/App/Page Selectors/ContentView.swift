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
    @AppStorage("hasDetails") private var hasDetails: Bool = false
    @AppStorage("loadingPresented") private var loadingPresented: Bool = false
    @State private var loadContentView: Bool = false
    
    func checkToken() async -> Bool {
        if let user = user.first {
            modelContext.delete(user)
        }
        let response = await AccountController.checkToken()
        if let safeResponse = response {
            modelContext.insert(safeResponse.data!)
            return true
        }
        return false
    }
    
    func checkDetails() async {
        let details = await AccountController.checkDetails()
        
        if let userDetails = details {
            if let user = user.first {
                user.details = userDetails
            }
        }
    }
    
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
                if await checkToken() {
                    await checkDetails()
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
