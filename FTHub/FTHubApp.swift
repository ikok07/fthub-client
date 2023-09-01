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
    @StateObject var setupController: SetupController = SetupController()
    @StateObject var healthKitController: HealthKitController = HealthKitController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self, isAutosaveEnabled: true)
                .environmentObject(numpadController)
                .environmentObject(authController)
                .environmentObject(baseAuthController)
                .environmentObject(codeAuthController)
                .environmentObject(setupController)
                .environmentObject(healthKitController)
        }
    }
}
