//
//  SetupController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import Foundation

enum Unit: String, CaseIterable {
    case metric, imperial
}

class SetupController: ObservableObject {
    
    @Published var activePage: Int = 0
    @Published var units: Unit = .metric
    
    @Published var gender: Gender? = .male
    @Published var age: Int?
    @Published var height: Int?
    @Published var weight: Int?
    @Published var goal: String?
    @Published var activeAppleHealth: Bool?
    @Published var activeNotifications: Bool?
    
    
    
}
