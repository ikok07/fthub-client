//
//  User.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation
import SwiftData

@Model
class User: Codable {
    @Attribute(.unique) let _id: String
    var name: String
    let email: String
    var photo: String
    let role: String
    var details: UserDetails?
    var hasFullDetails: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case _id
        case name
        case email
        case photo
        case role
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.photo = try container.decode(String.self, forKey: .photo)
        self.role = try container.decode(String.self, forKey: .role)
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
}

@Model
class UserDetails {
    
    var setupActivePage: Int = 0
    
    var units: Unit?
    var gender: Gender?
    var age: Int?
    var height: Int?
    var weight: Int?
    var workoutsPerWeek: Int?
    var goal: FitnessGoal?
    
    init(setupActivePage: Int) {
        self.setupActivePage = setupActivePage
    }
}
