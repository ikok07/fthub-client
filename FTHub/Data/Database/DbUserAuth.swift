//
//  DbUserAuth.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 19.09.23.
//

import Foundation
import CoreData

struct DbUserAuth {
    
    static let defaults = UserDefaults.standard
    
    static func convertApiDetailsToNormalDetails(_ details: ApiUserDetails) -> UserDetails {
        let newDetails = UserDetails(context: DB.shared.persistentContainer.viewContext)
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
    
    static func checkToken() async {
        let db = DB.shared
        let context = db.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = db.makeFetchRequest(request: fetchRequest)
        
        switch fetchData {
            
        case .success(let users):
            let response = await AccountController.checkToken()

            if let safeResponse = response {
                var lastToken: String?
                if users.count != 0 {
                    lastToken = users[0].token
                    context.delete(users[0])
                }
                
                let newMemoryUser = safeResponse.data!
                let newUser = User(context: context)
                newUser.mongoID = newMemoryUser._id
                newUser.token = lastToken
                newUser.name = newMemoryUser.name
                newUser.email = newMemoryUser.email
                newUser.photo = newMemoryUser.photo
                newUser.role = newMemoryUser.role
                context.insert(newUser)
                await self.checkDetails()
            }
            
        case .failure(let error):
            print(error)
        }
    }
    
    static func checkDetails() async {
        await K.Database.getCurrentUser() { user, context in
            let details = await AccountController.checkDetails()
            if let details = details {
                let newDetails = self.convertApiDetailsToNormalDetails(details)
                user.userDetails = newDetails
                user.hasFullDetails = true
                DB.shared.context.insert(user)
                DB.shared.saveContext()
            } else {
                let details = UserDetails(context: DB.shared.persistentContainer.viewContext)
                user.userDetails = details
                DB.shared.context.insert(user)
                DB.shared.saveContext()
            }
        }
        
    }
    
    static func confirmEmail(newUser: User) -> Bool {
        let db = DB.shared
        let context = db.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = db.makeFetchRequest(request: fetchRequest)
        
        switch fetchData {
        case .success(_):
            let details = UserDetails(context: context)
            details.setupActivePage = 0
            newUser.userDetails = details
            context.insert(newUser)
            db.saveContext()
            return true
        case .failure(let error):
            print("Failed fetching user from database: \(error)")
            return false
        }
    }
    
    static func twoFaAuth(newUser: User) async {
        let db = DB.shared
        let context = db.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = db.makeFetchRequest(request: fetchRequest)
        
        switch fetchData {
        case .success(let users):
            var lastToken: String?
            if users.count != 0 {
                lastToken = users[0].token
                context.delete(users[0])
            }
            newUser.token = lastToken
            context.insert(newUser)
            await self.checkDetails()
            
        case .failure(let error):
            print("Failed fetching user from database: \(error)")
        }
    }
    
    static func restorePassword(newUser: User) async {
//        await K.Database.getCurrentUser() { user in
//            let context = DB.shared.persistentContainer.viewContext
//            context.delete(user)
//            context.insert(newUser)
//            let details = await AccountController.checkDetails()
//            if let details = details {
//                let newDetails = self.convertApiDetailsToNormalDetails(details)
//                user.userDetails = newDetails
//                user.hasFullDetails = true
//                DB.shared.persistentContainer.viewContext.insert(user)
//                DB.shared.saveContext()
//            } else {
//                let details = UserDetails(context: DB.shared.persistentContainer.viewContext)
//                user.userDetails = details
//                DB.shared.persistentContainer.viewContext.insert(user)
//                DB.shared.saveContext()
//            }
//        }
    }
    
    static func logOut() async {
        await K.Database.getCurrentUser() { user, context in
            self.defaults.setValue(false, forKey: "userLoggedIn")
            DB.shared.context.delete(user)
            DB.shared.saveContext()
        }
    }
    
}
