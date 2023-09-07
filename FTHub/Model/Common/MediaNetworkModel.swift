//
//  MediaNetworkModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation

struct MediaResponse: NetworkCapable {
    let status: String
    let data: MediaResponseData
}

struct MediaResponseData: NetworkCapable {
    let user: User
}
