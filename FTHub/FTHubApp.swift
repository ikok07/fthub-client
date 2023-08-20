//
//  FTHubApp.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

@main
struct FTHubApp: App {
    
    @StateObject var messageController: MessageController = MessageController()
    @StateObject var numpadController: NumpadController = NumpadController()
    @StateObject var authController: ResendCodeController = ResendCodeController()
    @StateObject var baseAuthController: BaseAuthController = BaseAuthController()
    @StateObject var codeAuthController: CodeAuthController = CodeAuthController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(messageController)
                .environmentObject(numpadController)
                .environmentObject(authController)
                .environmentObject(baseAuthController)
                .environmentObject(codeAuthController)
        }
    }
}
