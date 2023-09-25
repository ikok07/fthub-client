//
//  Authentication.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import Foundation

struct Authentication {
    
    static let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
    
    static func signIn(email: String, password: String) async -> AccountAuthResponse? {

        let url: URL = URL(string: "\(K.API.apiURL)/\(self.language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/login")!
        let signInData: SignInPostData = SignInPostData(email: email, password: password)
        
        do {
            let response: AccountAuthResponse = try await Networking.sendPostRequest(data: signInData, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func signUp(name: String, email: String, password: String, passwordConfirm: String) async -> AccountAuthResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/\(self.language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/signup")!
        let signUpData: SignUpPostData = SignUpPostData(name: name, email: email, password: password, passwordConfirm: passwordConfirm)
        do {
            let response: AccountAuthResponse = try await Networking.sendPostRequest(data: signUpData, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func authTwoFa(email: String, token: String) async -> TwoFaAuthResponse? {
        
        let url: URL = URL(string: "\(K.API.apiURL)/\(self.language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/login/confirm/\(token)")!
        let data: TwoFaAuthPostData = TwoFaAuthPostData(email: email)
        
        do {
            let response: TwoFaAuthResponse = try await Networking.sendPostRequest(data: data, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func confirmEmail(email: String, confirmToken: String) async -> ConfirmEmailResponse? {
        let language = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        
        let url = URL(string: "\(K.API.apiURL)/\(self.language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/email/confirm/\(confirmToken)")!
        let data: ConfirmEmailPostData = ConfirmEmailPostData(email: email)

        do {
            let response: ConfirmEmailResponse = try await Networking.sendPostRequest(data: data, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    
    static func resendConfirmEmail(email: String) async -> ResendConfirmEmailResponse? {
        
        let url = URL(string: "\(K.API.apiURL)/\(self.language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV2)/user/email/resend")!
        let data = ResendConfirmEmailPostData(email: email)
        
        do {
            let response: ResendConfirmEmailResponse = try await Networking.sendPostRequest(data: data, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func sendConfirmEmail(email: String) async {
        let defaults = UserDefaults.standard
        let emailSentResponse = await Authentication.resendConfirmEmail(email: email)
        if emailSentResponse != nil && emailSentResponse?.status == "success" {
            await K.Database.getAppVariables() { variables, context in
                variables.userCurrentEmail = email
                variables.emailWithLinkSent = true
                variables.loadingPresented = false
            }
        } else {
            await Message.send(type: "error", message: "Error connecting to server")
        }
    }
    
    static func sendRestorePasswordEmail(email: String) async -> RestorePasswordEmailResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/\(self.language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV1)/user/password/reset")!
        let data = RestorePasswordEmailRequest(email: email)
        
        do {
            let response: RestorePasswordEmailResponse = try await Networking.sendPostRequest(data: data, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func changePassword(email: String, password: String, confirmPassword: String, token: String) async -> ChangePasswordResponse?{
        let url: URL = URL(string: "\(K.API.apiURL)/\(self.language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV1)/user/password/reset/\(token)")!
        let data: ChangePasswordRequest = ChangePasswordRequest(email: email, password: password, passwordConfirm: confirmPassword)
        
        do {
            let response: ChangePasswordResponse = try await Networking.sendPatchRequest(data: data, url: url)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func authToken(_ token: String) async -> AccountTokenAuthResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/\(self.language?.first?.prefix(2) ?? "en")/api/\(K.API.apiV1)/user/me")!
        
        do {
            let response: AccountTokenAuthResponse = try await Networking.sendGetRequest(url: url, token: token)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
    static func checkDetails(_ token: String) async -> ApiUserDetailsResponse? {
        let url: URL = URL(string: "\(K.API.apiURL)/en/api/\(K.API.apiV1)/user/detail")!
        
        do {
            let response: ApiUserDetailsResponse = try await Networking.sendGetRequest(url: url, token: token)
            return response
        } catch {
            print("Error making request to API: \(error)")
            return nil
        }
    }
    
}
