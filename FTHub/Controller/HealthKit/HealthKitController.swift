//
//  HealthKitController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import Foundation
import HealthKit

class HealthKitController: ObservableObject {
    
    @Published var healthStore: HKHealthStore?
    @Published var exerciseTime = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)!
    @Published var activeEnergyBurned = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
    @Published var bodyFatPercentage = HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!
    @Published var bmi = HKQuantityType.quantityType(forIdentifier: .bodyMassIndex)!
    @Published var height = HKQuantityType.quantityType(forIdentifier: .height)!
    @Published var weight = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
    
    @Published var query: HKStatisticsCollectionQuery?
    @Published var quantityTypes: Set<HKSampleType>?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = HKHealthStore()
        } else {
            print("HealthKit is not supported on this device")
        }
        self.quantityTypes = [exerciseTime, activeEnergyBurned, bodyFatPercentage, bmi, height, weight]
    }
    
    func requestAuthorization() -> Bool {
        
        var authStatus: Bool?
        
        healthStore?.requestAuthorization(toShare: self.quantityTypes, read: self.quantityTypes) { success, error in
            if success {
                authStatus = true
            } else {
                print(error ?? "")
                authStatus = false
            }
        }
        
        return authStatus ?? false
    }
    
    func getData() {
        
        let predicate = HKQuery.predicateForSamples(withStart: Date(), end: nil)
        
        self.query = HKStatisticsCollectionQuery(quantityType: weight, quantitySamplePredicate: predicate, anchorDate: Date(timeIntervalSinceNow: 300), intervalComponents: DateComponents(day: 1))
        
        self.query?.initialResultsHandler = { query, statisticsCollection, error in
            
        }
    }
    
    
    
    
}
