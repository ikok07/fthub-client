//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct ContentView: View {
    
    var confirmEmailController: ConfirmEmailController = ConfirmEmailController()
    
    @AppStorage("userLoggedIn") private var userLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            if userLoggedIn {
                CoachesPageView()
                    .animation(.easeOut, value: userLoggedIn)
            } else {
                BeforeAuthView()
            }
        }
        .onAppear {
            print(userLoggedIn)
        }
    }
}

#Preview {
    ContentView()
}
