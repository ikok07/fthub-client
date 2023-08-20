//
//  FTHubApp.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

@main
struct FTHubApp: App {
    
    @ObservedObject var messageController: MessageController = MessageController()
    @ObservedObject var numpadController: NumpadController = NumpadController()
    @ObservedObject var authController: AuthController = AuthController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(messageController)
                .environmentObject(numpadController)
                .environmentObject(authController)
        }
    }
}
