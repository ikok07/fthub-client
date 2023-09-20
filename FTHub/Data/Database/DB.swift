//
//  Database.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation
import CoreData

class DB {
    
    static let shared = DB()
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FTHub")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
        
        return container
    }()
    
    func makeFetchRequest<T: NSManagedObject>(request: NSFetchRequest<T>) -> Result<[T], Error> {
        let context = DB.shared.persistentContainer.viewContext
        do {
            let users = try context.fetch(request)
            return .success(users)
        } catch {
            return .failure(error)
        }
    }
    
    func saveContext(completion: (() -> Void)? = nil) {
        let context = DB.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving new context: \(error)")
            }
        }
    }
    
    
}
