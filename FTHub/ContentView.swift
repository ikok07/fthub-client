//
//  ContentView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TutorialImageView(imageName: "tutorial1")
                    .padding(.bottom, 10)
                
                VStack(spacing: 20) {
                    CustomHeadingView(upperPart: "Welcome to FTHub", bottomPart: "Train Smart")
                    
                    TutorialHeadlineView(text: "Discover all your fitness apps in one place. Create workouts or enter one of our custom fitness programs")
                }
                .padding(.bottom, 30)
                
                Button(action: {}, label: {
                    Text("Start")
                        .padding(.vertical, 10)
                })
                .buttonStyle(CTAButtonStyle())
            }
            .padding()
            .toolbar {
                Button(action: {}, label: {
                    Text("Skip")
                        .fontWeight(.bold)
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
