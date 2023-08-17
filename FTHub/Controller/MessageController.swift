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
    
    func sendLoginMessage(apiMessage: String) {
        if apiMessage == "Incorrect email or password" {
            messageText = "Incorrect email or password" // по-късно ще го направя за езиците
        } else if apiMessage == "Please provide email and password" {
            messageText = "Please provide email and password"
        } else {
            messageText = "An unknown error occured. Please try again later."
        }
        messageType = .error
        presentMessage()
    }

}
