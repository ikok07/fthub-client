//
//  SettingsProfileDataNetworkModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation


// MARK: - Form Data

struct SettingsProfileFormDataResponse: NetworkCapable {
    let status: String
    let data: SettingsProfileFormDataResponseData
}

struct SettingsProfileFormDataBody: NetworkCapable {
    let json: Data?
    let image: Data?
}

struct SettingsProfileFormDataResponseData: NetworkCapable {
    let user: User
}


// MARK: - Normal JSON

struct SettingsProfileDataBody: NetworkCapable {
    let gender: String
    let age: Int
    let height: Int
    let weight: Int
    let trainingFrequencyPerWeek: Int
    let units: String
    let goal: String
}

struct SettingsProfileDataResponse: NetworkCapable {
    let status: String
    let data: ApiUserDetailsResponseData
}
