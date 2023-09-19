//
//  AccountRequestModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import Foundation

struct AccountTokenAuthResponse: NetworkCapable {
    let status: String
    let data: MemoryUser?
}
