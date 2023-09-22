//
//  AccountController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation
import CoreData

final class AccountController {
    
    static func checkToken() async -> AccountTokenAuthResponse? {
        
        var response: AccountTokenAuthResponse?
        
        await K.Database.getCurrentUser() { user, context in
            response = await AccountModel.authToken(user.token ?? "")
        }
        
        return response
    }
    
    static func checkDetails() async -> ApiUserDetails? {
        let db = DB.shared
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let fetchData: Result<[User], Error> = db.makeFetchRequest(request: fetchRequest)
        
        switch fetchData {
        case .success(let users):
            if users.count != 0 {
                let details = await AccountModel.checkDetails(users[0].token ?? "")
                return details
            } else {
                print("There is no user in database")
                return nil
            }
        case .failure(let error):
            print("Failed fetching users from database: \(error.localizedDescription)")
            return nil
        }
        
        
    }
    
}
