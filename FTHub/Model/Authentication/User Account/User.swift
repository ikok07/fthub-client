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
    let _id: String
    let name: String
    let email: String
    let photo: String
    let role: String
    let details: UserDetails?
    
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
    
    var gender: String
    var age: Int
    var height: Double
    var weight: Double
    var goal: String
    var activeAppleHealth: Bool
    var activeNotifications: Bool
    
    init() {

    }
}
