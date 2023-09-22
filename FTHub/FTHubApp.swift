//
//  FTHubApp.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

@main
struct FTHubApp: App {
    @State var baseAuthController = BaseAuthController()
    @State var setupController = SetupController()
    @State var healthKitController = HealthKitController()
    let db: DB = DB.shared
    
    init() {
        Task {
            await DbApplication.initiate()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(baseAuthController)
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
