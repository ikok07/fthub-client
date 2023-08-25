//
//  NetworkMethods.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

struct Request {
    
    // MARK: - API Requests
    
    static func get<T: Codable>(url: URL, token: String) async -> Result<T, Error> {
        
        var request = URLRequest(url: url)
        print(token)
        request.httpMethod = "GET"
        request.setValue("keep-alive", forHTTPHeaderField: "Connection")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(data: data, encoding: .utf8))
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            print("Error getting data from API: \(error)")
            return .failure(error)
        }
    }
    
    static func create<T:Codable>(url: URL, body: Data) async -> Result<T, Error> {
        

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(data: data, encoding: .utf8))
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
    
    static func update<T: Codable>(url: URL, body: Data) async -> Result<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(data: data, encoding: .utf8))
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }

    }
    
}
