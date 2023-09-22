//
//  Constants.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import Foundation
import SwiftUI
import CoreData

struct K {
    
    // MARK: - Gradients
    struct Gradients {
        static let mainGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.accentColor, .customMint]), startPoint: .topLeading, endPoint: .bottomTrailing)
        static let secondaryGradient: LinearGradient = LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 0.27, green: 0.74, blue: 0.26).opacity(0.75), location: 0.00),
            Gradient.Stop(color: Color(red: 0.26, green: 0.74, blue: 0.64).opacity(0.75), location: 1.00),
            ],
            startPoint: UnitPoint(x: 0, y: 0),
            endPoint: UnitPoint(x: 1.26, y: 1.69)
            )
        
        static let errorGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.customDarkRed]), startPoint: .topLeading, endPoint: .bottomTrailing)
        
        static let redGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.customRed2]), startPoint: .topLeading, endPoint: .bottomTrailing)
        
        static let grayGradient: LinearGradient = LinearGradient(colors: [.textGray], startPoint: .leading, endPoint: .trailing)
        static let whiteGradient: LinearGradient = LinearGradient(colors: [.white], startPoint: .leading, endPoint: .trailing)
        static let whiteGradientForDark: LinearGradient = LinearGradient(colors: [.textfieldAppearance], startPoint: .leading, endPoint: .trailing)
        static let lightGrayGradient: LinearGradient = LinearGradient(colors: [.textGray.opacity(0.35)], startPoint: .leading, endPoint: .trailing)
        static let clearGradient: LinearGradient = LinearGradient(colors: [.clear], startPoint: .leading, endPoint: .trailing)
    }
    
    
    // MARK: - API
    struct API {
        static let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        static let apiURL: String = "https://api.fthub.eu"
        static let apiV1: String = "v1"
        static let apiV2: String = "v2"
    }
    
    // MARK: - Grid
    struct GridLayouts {
        static let standardColumnLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    }
    
    
    // MARK: - User
    struct UserDetails {
        static let minAge: Int = 16
        static let maxAge: Int = 60
        
        static let minHeight: Int = 120
        static let maxHeight: Int = 220
        
        static let minHeightInches: Double = 47.2
        static let maxHeightInches: Double = 86.6
        
        static let minWeight: Int = 40
        static let maxWeight: Int = 180
        
        static let minWeightLbs: Double = 88.0
        static let maxWeightLbs: Double = 397.0
    }
    
    
    // MARK: - Units
    struct Units {
        static let kgToLbs: Double = 2.2046226218488
        static let cmToInch: Double = 0.3937
        
        static func getHeightRange(units: Unit) -> [Double] {
            
            let step = units == .metric ? 1 : 0.1

            var values: [Double] = []
            var currentValue = units == .metric ? Double(K.UserDetails.minHeight) : K.UserDetails.minHeightInches

            while currentValue <= (units == .metric ? Double(K.UserDetails.maxHeight) : K.UserDetails.maxHeightInches) {
                values.append(currentValue)
                currentValue += step
            }

            return values
        }
        
        static func getWeightRange(units: Unit) -> [Double] {
            
            let step = units == .metric ? 1 : 0.1

            var values: [Double] = []
            var currentValue = units == .metric ? Double(K.UserDetails.minWeight) : K.UserDetails.minWeightLbs

            while currentValue <= (units == .metric ? Double(K.UserDetails.maxWeight) : K.UserDetails.maxWeightLbs) {
                values.append(currentValue)
                currentValue += step
            }

            return values
        }
    }
    
    // MARK: - Database
    
    struct Database {
        static func getUserToken() async -> String {
            var token: String = ""
            
            await self.getCurrentUser() { user, context in
                token = user.token ?? ""
            }
            return token
        }
        
        static func getCurrentUser(completionHandler: ((User, NSManagedObjectContext) async -> Void)? = nil, completionHandlerWithoutEmptyCheck: (([User], NSManagedObjectContext) async -> Void)? = nil) async {
            let db = DB.shared
            let context = db.context
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            let fetchData: Result<[User], Error> = db.makeFetchRequest(request: fetchRequest)
            
            switch fetchData {
            case .success(let users):
                if !users.isEmpty {
                    await completionHandler?(users[0], context)
                }
                await completionHandlerWithoutEmptyCheck?(users, context)
            case .failure(let error):
                print("Error getting current user from database: \(error.localizedDescription)")
            }
        }
        
        static func getAppVariables(completionHandler: ((AppVariables, NSManagedObjectContext) async -> Void)? = nil, completionHandlerWithoutEmptyCheck: (([AppVariables], NSManagedObjectContext) async -> Void)? = nil) async {
            let db = DB.shared
            let context = db.context
            let fetchRequest: NSFetchRequest<AppVariables> = AppVariables.fetchRequest()
            let fetchData: Result<[AppVariables], Error> = db.makeFetchRequest(request: fetchRequest)
            
            switch fetchData {
            case .success(let variables):
                if !variables.isEmpty {
                    await completionHandler?(variables[0], context)
                    db.saveContext()
                }
                await completionHandlerWithoutEmptyCheck?(variables, context)
                
            case .failure(let error):
                print("Error getting current variables from database: \(error.localizedDescription)")
            }
        }
        
    }
    
}
