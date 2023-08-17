//
//  NetworkMethods.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

struct Request {
    
    // MARK: - API Requests
    
    static func fetch<T: Codable>(url: URL) async -> T? {
        var response: T? = nil
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            response = decodedData
        } catch {
            print("Error getting data from API: \(error)")
        }
        return response
    }
    
    static func create<T:Codable>(url: URL, body: Data) async -> Result<T, Error> {
        

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
    
}
