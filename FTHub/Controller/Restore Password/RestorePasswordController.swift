//
//  RestorePasswordController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import Foundation

class RestorePasswordController: ObservableObject {
    
    @Published var emailSent: Bool = false
    @Published var token: String = ""
    
    @Published var sendMsg: (() -> Void)?
    
    func sendEmail(email: String) {
        
    }
    
}
