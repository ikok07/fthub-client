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
        
        DispatchQueue.main.async {
            defaults.setValue(message, forKey: "messageContent")
            defaults.setValue(type, forKey: "messageType")
            
            withAnimation {
                defaults.setValue(true, forKey: "messagePresented")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    defaults.setValue(false, forKey: "messagePresented")
                }
            }
        }
    }
    
}
