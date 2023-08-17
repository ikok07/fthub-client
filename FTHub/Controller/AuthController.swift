//
//  AuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

struct AuthController {
    
    func signIn(email: String, password: String) async -> SignInResponse? {
        let url: URL = URL(string: "\(K.apiURL)/en/api/v1/users/login")!
        let signInData: SignInPostData = SignInPostData(email: email, password: password)
        
        var response: SignInResponse? = nil
        
        do {
            let jsonData = try JSONEncoder().encode(signInData)

            let result: Result<SignInResponse, Error> = await Request.create(url: url, body: jsonData)
            switch result {
            case .success(let data):
                response = data
            case .failure(let error):
                print("Error getting userData: \(error)")
            }
        } catch {
            print("Could not encode data to json: \(error)")
        }
        return response
    }
    
    func signUp(name: String, email: String, password: String, passwordConfirm: String) async -> SignUpResponse? {
        let url: URL = URL(string: "\(K.apiURL)/en/api/v1/users/signup")!
        let data: SignUpPostData = SignUpPostData(name: name, email: email, password: password, passwordConfirm: passwordConfirm)
        
        var response: SignUpResponse? = nil
        
        do {
            print("DATA -> \(data)")
            let jsonData = try JSONEncoder().encode(data)
            
            let result: Result<SignUpResponse, Error> = await Request.create(url: url, body: jsonData)
            switch result {
            case .success(let result):
                response = result
            case .failure(let error):
                print("Could not get response from API: \(error)")
            }
        } catch {
            print("Could not encode data into JSON: \(error)")
        }
        return response
    }
    
    func authEmail(email: String, code: Int, type: EmailAuthType) async -> EmailAuthRequest? {
        let url: URL = URL(string: "\(K.apiURL)/en/api/v1/users/\(type == .twofa ? "login" : "email")/confirm")!
        let data: EmailAuthPostData = EmailAuthPostData(email: email, token: code)
        
        var response: EmailAuthRequest? = nil
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            
            let result: Result<EmailAuthRequest, Error> = await Request.create(url: url, body: jsonData)
            switch result {
            case .success(let data):
                response = data
            case .failure(let error):
                print("Could not get code approval from API: \(error)")
            }
        } catch {
            print("Error converting auth data to json: \(error)")
        }
        return response
    }
    
    
}
