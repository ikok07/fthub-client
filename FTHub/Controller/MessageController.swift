//
//  MessageController.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 17.08.23.
//

import Foundation
import SwiftUI

class MessageController: ObservableObject {
    @Published var messagePresented: Bool = false
    @Published var messageText: String = ""
    @Published var messageType: CustomMessageType = .error
    
    private func presentMessage() {
        withAnimation {
            messagePresented = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.messagePresented = false
            }
        }
    }
    
    func sendMessage(type: CustomMessageType, apiMessage: String) {
        messageText = apiMessage
        messageType = type
        presentMessage()
    }

}
