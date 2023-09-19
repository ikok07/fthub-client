//
//  Database.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Observation
import Foundation
import CoreData

@Observable class DB {
    
    static let shared = DB()
    let container = NSPersistentContainer(name: "FTHub")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error)")
            }
        }
    }
    
    static func makeFetchRequest<T: NSManagedObject>(context: NSManagedObjectContext, request: NSFetchRequest<T>) -> Result<[T], Error> {
        do {
            let users = try context.fetch(request)
            return .success(users)
        } catch {
            return .failure(error)
        }
    }
    
    static func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error saving new context: \(error)")
        }
    }
    
    
}
