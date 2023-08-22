//
//  Authentication.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import Foundation

struct Authentication {
    
    
    
    static func signIn(email: String, password: String) async -> AccountAuthResponse? {
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        let url: URL = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV1)/user/login")!
        let signInData: SignInPostData = SignInPostData(email: email, password: password)
        
        var response: AccountAuthResponse? = nil
        
        do {
            let jsonData = try JSONEncoder().encode(signInData)

            let result: Result<AccountAuthResponse, Error> = await Request.create(url: url, body: jsonData)
            switch result {
            case .success(let data):
                response = data
                print("DATA:: \(data)")
            case .failure(let error):
                print("Error getting userData: \(error)")
            }
        } catch {
            print("Could not encode data to json: \(error)")
        }
        return response
    }
    
    static func signUp(name: String, email: String, password: String, passwordConfirm: String) async -> AccountAuthResponse? {
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        let url: URL = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/signup")!
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
    
    static func authTwoFa(email: String, code: Int) async -> TwoFaAuthResponse? {
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        let url: URL = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV1)/user/login/confirm")!
        let data: TwoFaAuthPostData = TwoFaAuthPostData(email: email, token: code)
        var response: TwoFaAuthResponse? = nil
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            
            let result: Result<TwoFaAuthResponse, Error> = await Request.create(url: url, body: jsonData)
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
    
    static func confirmEmail(email: String, confirmToken: String) async -> ConfirmEmailResponse? {
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        let url = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/email/confirm/\(confirmToken)")!
        let data: ConfirmEmailPostData = ConfirmEmailPostData(email: email)

        do {
            let jsonData = try JSONEncoder().encode(data)
            
            let result: Result<ConfirmEmailResponse, Error> = await Request.create(url: url, body: jsonData)
            switch result {
            case .success(let response):
                return response
            case .failure(let error):
                print("Could not decode jsonData for email authentication: \(error)")
                return nil
            }
            
        } catch {
            print("Could not encode JSON: \(error)")
            return nil
        }
    }
    
    
    static func resendConfirmEmail(email: String) async -> ResendConfirmEmailResponse? {
        
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        let url = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/email/resend")!
        let data = ResendConfirmEmailPostData(email: email)
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            
            let result: Result<ResendConfirmEmailResponse, Error> = await Request.create(url: url, body: jsonData)
            switch result {
            case .success(let response):
                return response
            case .failure(let error):
                print("Could not send new confirm email \(error)")
                return nil
            }
        } catch {
            print("Could not encode data to JSON: \(error)")
            return nil
        }
    }
    
}
