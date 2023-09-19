//
//  DbUserAuth.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 19.09.23.
//

import Foundation
import CoreData

struct DbUserAuth {
    
    static func convertApiDetailsToNormalDetails(_ details: ApiUserDetails, context: NSManagedObjectContext) -> UserDetails {
        let newDetails = UserDetails(context: context)
        newDetails.setupActivePage = 0
        newDetails.age = Int16(details.age)
        newDetails.units = details.units
        newDetails.gender = details.gender
        newDetails.goal = details.goal
        newDetails.height = Int16(details.height)
        newDetails.weight = Int16(details.weight)
        newDetails.workoutsPerWeek = Int16(details.trainingFrequencyPerWeek)
        return newDetails
    }
    
    static func checkToken() async -> Bool {
        let db = DB.shared
        let context = db.container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = DB.makeFetchRequest(context: context, request: fetchRequest)
        
        switch fetchData {
            
        case .success(let users):
            context.delete(users[0])
            let response = await AccountController.checkToken()
            if let safeResponse = response {
                context.insert(safeResponse.data!)
                do {
                    try context.save()
                } catch {
                    print("Error saving new user: \(error)")
                }
                return true
            }
            
        case .failure(let error):
            print(error)
            
        }
        return false
    }
    
    static func checkDetails() async -> Bool {
        let db = DB.shared
        let context = db.container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = DB.makeFetchRequest(context: context, request: fetchRequest)
        
        switch fetchData {
        case .success(let users):
            let details = await AccountController.checkDetails()
            if let details = details {
                let newDetails = self.convertApiDetailsToNormalDetails(details, context: context)
                users[0].userDetails = newDetails
                context.insert(users[0])
                do {
                    try context.save()
                    return true
                } catch {
                    print("Error saving details from API to User Object: \(error)")
                }
            }
            
        case .failure(let error):
            print("Error fetching user data from database: \(error)")
        }
        
        return false
    }
    
    static func confirmEmail() {
        let db = DB.shared
        let context = db.container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = DB.makeFetchRequest(context: context, request: fetchRequest)
        
        switch fetchData {
        case .success(let users):
            let details = UserDetails(context: context)
            details.setupActivePage = 0
            users[0].userDetails = details
            context.insert(users[0])
            do {
                try context.save()
            } catch {
                print("Failed saving new user details to database: \(error)")
            }
        case .failure(let error):
            print("Failed fetching user from database: \(error)")
        }
    }
    
    static func twoFaAuth(newUser: User) async {
        let db = DB.shared
        let context = db.container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = DB.makeFetchRequest(context: context, request: fetchRequest)
        
        switch fetchData {
        case .success(let users):
            let details = await AccountController.checkDetails()
            if let userDetails = details {
                let newDetails = self.convertApiDetailsToNormalDetails(userDetails, context: context)
                context.delete(users[0])
                newUser.userDetails = newDetails
                context.insert(newUser)
                do {
                    try context.save()
                } catch {
                    print("Error saving new user to database: \(error)")
                }
            }
        case .failure(let error):
            print("Failed fetching user from database: \(error)")
        }
    }
    
    static func logOut() {
        let db = DB.shared
        let context = db.container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = DB.makeFetchRequest(context: context, request: fetchRequest)
        
        switch fetchData {
        case .success(let users):
            context.delete(users[0])
        case .failure(let error):
            print("Failed deleting user from database: \(error)")
        }
    }
    
}
