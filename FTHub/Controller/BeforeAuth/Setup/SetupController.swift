//
//  SetupController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import Foundation
import Observation

enum Unit: String, CaseIterable, Codable {
    case metric = "metric"
    case imperial = "imperial"
}

@Observable class SetupController {
    
    var activePage: Int = 0
    var units: Unit = .metric
    var gender: Gender? = .Male
    var age: Int?
    var height: Double?
    var weight: Int?
    var workoutsPerWeek: Int?
    var goal: FitnessGoal?
    
    func saveDetailsToServer(completion: ((Bool) -> Void)? = nil) async {
        await SetupModel.saveDetailsToServer(age: self.age ?? 18, height: self.height ?? 180, weight: self.weight ?? 70, workoutsPerWeek: self.workoutsPerWeek ?? 3, gender: self.gender?.rawValue ?? Gender.Male.rawValue, units: units, goal: self.goal?.rawValue ?? FitnessGoal.Balance.rawValue, completion: completion)
    }
    
}
