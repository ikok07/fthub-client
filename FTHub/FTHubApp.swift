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
    let db: DB = DB.shared
    
    init() {
        Task {
            await DbApplication.initiate()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authController)
                .environmentObject(baseAuthController)
                .environment(setupController)
                .environment(healthKitController)
                .environment(\.managedObjectContext, db.persistentContainer.viewContext)
                .onAppear {
                    Task {
                        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
                    }
                }
        }
    }
}
