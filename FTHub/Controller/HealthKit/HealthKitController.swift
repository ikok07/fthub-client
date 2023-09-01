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
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = HKHealthStore()
        } else {
            
        }
    }
    
    func requestAuthorization() {
        
        
        healthStore?.requestAuthorization(toShare: [exerciseTime, activeEnergyBurned, bodyFatPercentage, bmi, height, weight], read: nil) { success, error in
            
        }
        
    }
    
}
