//
//  Message.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 22.08.23.
//

import Foundation
import SwiftUI

struct Message {
    
    static func sendMessage(type: String, message: String) {
        
        let defaults = UserDefaults.standard
        var messagePresented = defaults.value(forKey: "messagePresented") as! Bool
        var message = defaults.value(forKey: "messageType") as! String
        var messageType = defaults.value(forKey: "messageType") as! String
        
        
        DispatchQueue.main.async {
            message = message
            messageType = type
            
            withAnimation {
                messagePresented = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    messagePresented = false
                }
            }
        }
    }
    
}
