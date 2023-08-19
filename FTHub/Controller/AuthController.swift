//
//  AuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

struct AuthController {
    
    private let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
    
    func signIn(email: String, password: String) async -> AccountAuthResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/v1/user/login")!
        let signInData: SignInPostData = SignInPostData(email: email, password: password)
        
        var response: AccountAuthResponse? = nil
        
        do {
            let jsonData = try JSONEncoder().encode(signInData)

            let result: Result<AccountAuthResponse, Error> = await Request.create(url: url, body: jsonData)
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
    
    func signUp(name: String, email: String, password: String, passwordConfirm: String) async -> AccountAuthResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/v1/user/signup")!
        let data: SignUpPostData = SignUpPostData(name: name, email: email, password: password, passwordConfirm: passwordConfirm)
        
        var response: AccountAuthResponse? = nil
        
        do {
            print("DATA -> \(data)")
            let jsonData = try JSONEncoder().encode(data)
            
            let result: Result<AccountAuthResponse, Error> = await Request.create(url: url, body: jsonData)
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
        let url: URL = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/v1/user/\(type == .twofa ? "login" : "email")/confirm")!
        let data: EmailAuthPostData = EmailAuthPostData(email: email, token: code)
        
        var response: EmailAuthRequest? = nil
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            
            let result: Result<EmailAuthRequest, Error> = await Request.create(url: url, body: jsonData)
            switch result {
            case .success(let data):
                response = data
            case .failure(let error):
                print("Could not decode jsonData for email authentication: \(error)")
            }
        } catch {
            print("Error converting auth data to json: \(error)")
        }
        return response
    }
    
    
}
