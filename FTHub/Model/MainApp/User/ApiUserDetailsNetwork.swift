//
//  ApiUserDetails.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 3.09.23.
//

import Foundation


struct ApiUserDetailsPostData: Codable {
    let gender: String
    let age: Int
    let height: Int
    let weight: Int
    let trainingFrequencyPerWeek: Int
    let units: String
    let goal: String
}

struct ApiUserDetailsResponse: NetworkCapable {
    let status: String
    let data: ApiUserDetailsResponseData
}

struct ApiUserDetailsResponseData: Codable {
    let userDetails: ApiUserDetails
}

struct ApiUserDetails: Codable {
    let age: Int
    let height: Double
    let weight: Int
    let trainingFrequencyPerWeek: Int
    let gender: String?
    let units: String
    let goal: String?
}
