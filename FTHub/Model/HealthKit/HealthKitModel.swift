//
//  HealthKitModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import Foundation
import HealthKit


struct HealthKitModel {
    static func requestPermission(store: HKHealthStore, healthData: Set<HKSampleType>, completion: ((Bool) -> Void)?) {
        
        guard HKHealthStore.isHealthDataAvailable() else { return  }
        
        store.requestAuthorization(toShare: healthData, read: healthData) { success, error in
            if success {
                completion?(true)
            } else {
                if error != nil {
                    print("Error authorizing health data: \(error!)")
                }
                completion?(false)
            }
        }
    }
}
