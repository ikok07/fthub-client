//
//  FTHubApp.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

@main
struct FTHubApp: App {
    
    @StateObject var numpadController: NumpadController = NumpadController()
    @StateObject var authController: ResendCodeController = ResendCodeController()
    @StateObject var baseAuthController: BaseAuthController = BaseAuthController()
    @StateObject var codeAuthController: TwoFaAuthController = TwoFaAuthController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self)
                .environmentObject(numpadController)
                .environmentObject(authController)
                .environmentObject(baseAuthController)
                .environmentObject(codeAuthController)
        }
    }
}
