//
//  User.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation
import SwiftData

struct MemoryUser: Codable {
    let _id: String
    var name: String
    let email: String
    var photo: String
    let role: String
    var details: MemoryUserDetails?
//    var hasFullDetails: Bool = false
}

struct MemoryUserDetails: Codable {
    var setupActivePage: Int = 0
    var units: Unit?
    var gender: Gender?
    var age: Int?
    var height: Double?
    var weight: Int?
    var workoutsPerWeek: Int?
    var goal: FitnessGoal?
}
