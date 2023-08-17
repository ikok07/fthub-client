//
//  FTHubApp.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

@main
struct FTHubApp: App {
    
    @StateObject var messageController: MessageController = MessageController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(messageController)
        }
    }
}
