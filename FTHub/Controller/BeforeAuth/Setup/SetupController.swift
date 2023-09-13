//
//  SetupController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import Foundation

enum Unit: String, CaseIterable, Codable {
    case metric = "metric"
    case imperial = "imperial"
}

class SetupController: ObservableObject {
    
    @Published var activePage: Int = 0
    @Published var units: Unit?
    
    @Published var gender: Gender? = .Male
    @Published var age: Int?
    @Published var height: Int?
    @Published var weight: Int?
    @Published var workoutsPerWeek: Int?
    @Published var goal: FitnessGoal?
    
    func saveDetailsToServer(completion: ((Bool) -> Void)? = nil) async {
        await SetupModel.saveDetailsToServer(age: self.age ?? 18, height: self.height ?? 180, weight: self.weight ?? 70, workoutsPerWeek: self.workoutsPerWeek ?? 3, gender: self.gender?.rawValue ?? Gender.Male.rawValue, units: units ?? .metric, goal: self.goal?.rawValue ?? FitnessGoal.Balance.rawValue, completion: completion)
    }
    
}
