//
//  HealthKitController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import Foundation
import HealthKit

enum HealthKitError: String, Error {
    case notAvailable = "HealthKit is not available on this device"
}

class HealthKitController: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    var authStatus: Bool = false
    
    func checkAuthStatus() {
        do {
            authStatus = try HealthKitModel.requestAuthorization(store: self.healthStore)
        } catch {
            print(error)
        }
    }
}
