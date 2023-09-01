//
//  HealthKitModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import Foundation
import HealthKit


struct HealthKitModel {
    static func requestAuthorization(store: HKHealthStore, healthData: Set<HKSampleType>, completion: (() -> Void)?) throws -> [HKAuthorizationStatus] {
        
        var authStatus: [HKAuthorizationStatus] = []
        
        if HKHealthStore.isHealthDataAvailable() {
            store.requestAuthorization(toShare: healthData, read: healthData) { success, error in
                if error != nil {
                    print("Error authorizing health data: \(error!)")
                } else {
                    for data in healthData {
                        authStatus.append(store.authorizationStatus(for: data))
                    }
                    completion?()
                }
            }
        } else {
            throw HealthKitError.notAvailable
        }
        return authStatus
    }
}
