//
//  HealthKitController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import Foundation
import HealthKit
import Observation

enum HealthKitError: String, Error {
    case notAvailable = "HealthKit is not available on this device"
}

@Observable class HealthKitController {
    
    let healthStore = HKHealthStore()
    
    let healthData = Set([
        HKQuantityType.workoutType(),
        HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!,
        HKQuantityType.quantityType(forIdentifier: .bodyMassIndex)!,
        HKQuantityType.quantityType(forIdentifier: .height)!,
        HKQuantityType.quantityType(forIdentifier: .bodyMass)!
    ])
    
    func askForAuthorization(completion: ((Bool) -> Void)?) {
        HealthKitModel.requestPermission(store: healthStore, healthData: healthData, completion: completion)
    }
}
