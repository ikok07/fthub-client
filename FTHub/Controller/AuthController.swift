//
//  AuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.08.23.
//

import Foundation

struct AuthController {
    
    func signIn(email: String, password: String) async -> SignInRequest? {
        let url: URL = URL(string: "\(K.apiURL)/en/api/v1/users/login")!
        let signInData: SignInPostData = SignInPostData(email: email, password: password)
        
        var response: SignInRequest? = nil
        
        do {
            let jsonData = try JSONEncoder().encode(signInData)

            let result: Result<SignInRequest, Error> = await Request.create(url: url, body: jsonData)
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
    
    func performTwoFa(email: String, code: Int) async -> TwoFaRequest? {
        let url: URL = URL(string: "\(K.apiURL)/en/api/v1/users/login/confirm")!
        let data: TwoFaPostData = TwoFaPostData(email: email, token: code)
        
        var response: TwoFaRequest? = nil
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            
            let result: Result<TwoFaRequest, Error> = await Request.create(url: url, body: jsonData)
            switch result {
            case .success(let data):
                response = data
            case .failure(let error):
                print("Error getting twoFa approval from API: \(error)")
            }
        } catch {
            print("Error converting twoFa data to json: \(error)")
        }
        return response
    }
}
