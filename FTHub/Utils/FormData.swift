//
//  FormData.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation

struct FormData {
    
    static func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    static func createFormDataBody(jsonData: Data?, imageData: Data?, boundary: String) -> Data {
        var body = Data()
        
        
        if jsonData != nil {
            // Add JSON data
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"name\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
            body.append(jsonData!)
        }
        
        if imageData != nil {
            // Add image data
            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData!)
        }
        
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
}
