//
//  Networking.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.08.23.
//

import Foundation

struct Networking {
    
    static func startPostRequest<T: NetworkCapable, V: Codable>(data: V, url: URL) async throws -> T {
        do {
            let jsonData = try JSONEncoder().encode(data)
            print(String(data: jsonData, encoding: .utf8))
            let result: Result<T, Error> = await Request.create(url: url, body: jsonData)
            switch result {
            case .success(let response):
                return response
            case .failure(let error):
                throw error
            }
        }
    }
    
}
