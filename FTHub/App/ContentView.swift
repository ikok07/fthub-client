//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("showTutorial") private var showTutorial: Bool = true
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    
    @State private var confirmedEmail: Bool = false
    
    var body: some View {
        ZStack {
            if self.showTutorial {
                TutorialMainView()
            } else if userLoggedIn {
                CoachesPageView()
            } else {
                MainAccountAuthView()
            }
        }
        .animation(.easeOut, value: showTutorial)
        .onOpenURL { url in
            
            if url.absoluteString.contains("email/confirm/") {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
