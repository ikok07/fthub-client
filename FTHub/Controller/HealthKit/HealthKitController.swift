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
    
    var authStatus: [HKAuthorizationStatus] = []
    
    let healthData = Set([
        HKQuantityType.workoutType(),
        HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!,
        HKQuantityType.quantityType(forIdentifier: .bodyMassIndex)!,
        HKQuantityType.quantityType(forIdentifier: .height)!,
        HKQuantityType.quantityType(forIdentifier: .bodyMass)!
    ])
    
    func askForAuthorization(completion: (() -> Void)?) {
        do {
            authStatus = try HealthKitModel.requestAuthorization(store: self.healthStore, healthData: self.healthData, completion: completion)
        } catch {
            print(error)
        }
    }
}
