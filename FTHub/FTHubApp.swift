//
//  FTHubApp.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

@main
struct FTHubApp: App {
    
    @StateObject var authController: ResendCodeController = ResendCodeController()
    @StateObject var baseAuthController: BaseAuthController = BaseAuthController()
    @State var setupController: SetupController = SetupController()
    @State var healthKitController: HealthKitController = HealthKitController()
    @State private var db: DB = DB()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authController)
                .environmentObject(baseAuthController)
                .environment(setupController)
                .environment(healthKitController)
                .environment(\.managedObjectContext, db.container.viewContext)
        }
    }
}
