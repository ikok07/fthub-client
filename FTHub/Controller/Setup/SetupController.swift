//
//  SetupController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import Foundation

class SetupController: ObservableObject {
    
    @Published var gender: Gender?
    @Published var age: Int?
    @Published var height: Double?
    @Published var weight: Double?
    @Published var goal: String?
    @Published var activeAppleHealth: Bool?
    @Published var activeNotifications: Bool?
    
    
    
}
