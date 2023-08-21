//
//  BaseAuthController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 20.08.23.
//

import Foundation

class BaseAuthController: ObservableObject {
    
    private let accountAuthModel: AccountAuthModel = AccountAuthModel()
    
    @Published var activeOption: AuthOption?
    @Published var name: String?
    @Published var email: String?
    @Published var password: String?
    @Published var confirmPassword: String?
    @Published var sendBaseAuthMsg: ((AccountAuthResponse?) -> Void)?
    
    
    func saveData(activeOption: AuthOption, name: String, email: String, password: String, confirmPassword: String) {
        self.activeOption = activeOption
        self.email = email
        self.password = password
        
        if name != "" {
            self.name = name
            self.confirmPassword = confirmPassword
        }
        
    }
    
    func authenticateUser() {
        accountAuthModel.authenticate(activeOption: self.activeOption!, name: self.name, email: self.email!, password: self.password!, confirmPassword: self.confirmPassword, sendMsg: self.sendBaseAuthMsg!)
    }
    
}
