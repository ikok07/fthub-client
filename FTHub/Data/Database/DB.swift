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
    private init() {
        persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FTHub")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func performBackgroundTask(block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
    @objc func backgroundContextDidSave(notification: Notification) {
        guard let notificationContext = notification.object as? NSManagedObjectContext else { return }
        
        guard notificationContext != context else {
            return
        }
        
        context.perform {
            self.context.mergeChanges(fromContextDidSave: notification)
        }
    }
    
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
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving new context: \(error)")
            }
        }
    }
    
    
}
