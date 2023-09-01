//
//  HealthKitModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import Foundation
import HealthKit


struct HealthKitModel {
    static func requestAuthorization(store: HKHealthStore) throws -> Bool {
        
        var authStatus: Bool = false
        
        let healthData = Set([
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!,
            HKQuantityType.quantityType(forIdentifier: .bodyMassIndex)!,
            HKQuantityType.quantityType(forIdentifier: .height)!,
            HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        ])
        
        if HKHealthStore.isHealthDataAvailable() {
            store.requestAuthorization(toShare: healthData, read: healthData) { success, error in
                if success {
                    authStatus = true
                } else {
                    print("Error authorizing health data: \(error!)")
                }
            }
        } else {
            throw HealthKitError.notAvailable
        }
        return authStatus
    }
}
