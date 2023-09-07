//
//  Networking.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.08.23.
//

import Foundation

struct Networking {
    
    static func sendGetRequest<T: NetworkCapable>(url: URL, token: String) async throws -> T {
        let result: Result<T, Error> = await Request.get(url: url, token: token)
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    static func sendPostRequest<T: NetworkCapable, V: Codable>(data: V, url: URL, authToken: String? = nil) async throws -> T {
            let jsonData = try JSONEncoder().encode(data)
            print(String(data: jsonData, encoding: .utf8))
        
        let result: Result<T, Error> = await Request.create(url: url, body: jsonData, authToken: authToken)
            switch result {
            case .success(let response):
                return response
            case .failure(let error):
                throw error
            }
    }
    
    static func sendPatchRequest<T: NetworkCapable, V: Codable>(data: V, url: URL, authToken: String? = nil) async throws -> T {
        let jsonData = try JSONEncoder().encode(data)
        print(String(data: jsonData, encoding: .utf8))
        let result: Result<T, Error> = await Request.update(url: url, body: jsonData, authToken: authToken)
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
}
