//
//  TutorialFirstPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialStartPageView: View {
    
    @Binding var tutorialStarted: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TutorialImageView(imageName: "tutorial1")
                    .padding(.bottom, 10)
                
                VStack(spacing: 20) {
                    TutorialHeadingView(upperPart: "Welcome to FTHub", bottomPart: "Train Smart")
                    
                    TutorialHeadlineView(text: "Discover all your fitness apps in one place. Create workouts or enter one of our custom fitness programs")
                }
                .padding(.bottom, 30)
                
                Button(action: {
                    withAnimation(.easeOut) {
                        tutorialStarted = true
                    }
                }, label: {
                    Text("Start")
                        .padding(.vertical, 10)
                })
                .buttonStyle(CTAButtonStyle())
            }
            .padding()
            .toolbar {
                Button(action: {
                    
                }, label: {
                    Text("Skip")
                        .fontWeight(.bold)
                })
            }
        }    }
}

#Preview {
    TutorialStartPageView(tutorialStarted: .constant(false))
}
