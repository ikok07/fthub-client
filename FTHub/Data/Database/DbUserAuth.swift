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
        newDetails.height = Double(details.height)
        newDetails.weight = Double(details.weight)
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
                await DbApplication.sendLog(description: "No details found for user")
            }
        }
        
    }
    
    static func confirmEmail(response: ConfirmEmailResponse) -> Bool {
        let db = DB.shared
        let context = db.context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = db.makeFetchRequest(request: fetchRequest)
        
        switch fetchData {
        case .success(let users):
            if !users.isEmpty {
                for user in users {
                    context.delete(user)
                }
            }
            
            let user = User(context: context)
            let details = UserDetails(context: context)
            user.mongoID = response.data.user._id
            user.name = response.data.user.name
            user.email = response.data.user.email
            user.photo = response.data.user.photo
            user.role = response.data.user.role
            user.token = response.token
            user.userDetails = details
            
            context.insert(user)
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
    
        await K.Database.getCurrentUser(completionHandlerWithoutEmptyCheck: { users, context in
            if !users.isEmpty {
                for user in users {
                    context.delete(user)
                }
            }
            context.insert(newUser)
            let details = await AccountController.checkDetails()
            if let details = details {
                let newDetails = self.convertApiDetailsToNormalDetails(details)
                newUser.userDetails = newDetails
                newUser.hasFullDetails = true
                context.insert(newUser)
            } else {
                let details = UserDetails(context: context)
                newUser.userDetails = details
                context.insert(newUser)
            }
            DB.shared.saveContext()
        })
    }
    
    static func logOut() async {
        await K.Database.getCurrentUser(completionHandlerWithoutEmptyCheck:  { users, context in
            if !users.isEmpty {
                await DbApplication.initiate()
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    context.delete(users[0])
                    DB.shared.saveContext()
                }
            }
        })
    }
    
}
