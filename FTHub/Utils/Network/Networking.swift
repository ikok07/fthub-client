//
//  Networking.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.08.23.
//

import Foundation

enum NetworkError: String, Error {
    case undefinedNetworkError = "Error sending patch request: no success, no failure"
}

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
    
    static func sendPatchRequest<T: NetworkCapable, V: Codable>(data: V, url: URL, authToken: String? = nil, formData: Bool = false) async throws -> T {
        var jsonData: Data?
        
        if !formData {
            jsonData = try JSONEncoder().encode(data)
            print("SEND DATA: \(String(data: jsonData!, encoding: .utf8))")
        }
        
        var result: Result<T, Error>?
        
        if formData {
            let body = data as! SettingsProfileFormDataBody
            let name = body.name.data(using: .utf8)!
            let image = body.image
            result = await Request.update(url: url, body: name, imageBody: image, authToken: authToken, formData: formData)
        } else {
            result = await Request.update(url: url, body: jsonData!, authToken: authToken, formData: formData)
        }
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        case .none:
            throw NetworkError.undefinedNetworkError
        }
    }
    
}
