//
//  SettingsProfileDataNetworkModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation


struct SettingsProfileDataBody: NetworkCapable {
    let gender: String
    let age: Int
    let height: Int
    let weight: Int
    let trainingFrequencyPerWeek: Int
    let goal: String
}

struct SettingsProfileDataResponse: NetworkCapable {
    let status: String
    let data: ApiUserDetailsResponseData
}
