//
//  Database.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation
import SwiftData

struct Database {
    
    @MainActor static func saveUserData(_ user: User) {
        do {
            let container = try ModelContainer(for: User.self)
            let context = container.mainContext
            
            context.insert(user)
            try context.save()
        } catch {
            print("Error saving user to swiftdata: \(error)")
        }
    }
    
}
