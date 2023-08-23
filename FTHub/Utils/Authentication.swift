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
        
        do {
            let response: AccountAuthResponse = try await Networking.startPostRequest(data: signInData, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func signUp(name: String, email: String, password: String, passwordConfirm: String) async -> AccountAuthResponse? {
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        let url: URL = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/signup")!
        let signUpData: SignUpPostData = SignUpPostData(name: name, email: email, password: password, passwordConfirm: passwordConfirm)
        
        do {
            let response: AccountAuthResponse = try await Networking.startPostRequest(data: signUpData, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func authTwoFa(email: String, code: Int) async -> TwoFaAuthResponse? {
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        let url: URL = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV1)/user/login/confirm")!
        let data: TwoFaAuthPostData = TwoFaAuthPostData(email: email, token: code)
        
        do {
            let response: TwoFaAuthResponse = try await Networking.startPostRequest(data: data, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func confirmEmail(email: String, confirmToken: String) async -> ConfirmEmailResponse? {
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        let url = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/email/confirm/\(confirmToken)")!
        let data: ConfirmEmailPostData = ConfirmEmailPostData(email: email)

        do {
            let response: ConfirmEmailResponse = try await Networking.startPostRequest(data: data, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    
    static func resendConfirmEmail(email: String) async -> ResendConfirmEmailResponse? {
        
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        let url = URL(string: "\(K.API.apiURL)/\(language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/email/resend")!
        let data = ResendConfirmEmailPostData(email: email)
        
        do {
            let response: ResendConfirmEmailResponse = try await Networking.startPostRequest(data: data, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
}
