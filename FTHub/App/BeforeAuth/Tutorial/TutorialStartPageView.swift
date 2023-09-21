//
//  TutorialFirstPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialStartPageView: View {
    
    @FetchRequest(sortDescriptors: []) private var variables: FetchedResults<AppVariables>
    
    @Binding var tutorialStarted: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TutorialImageView(imageName: "tutorial1")
                    .padding(.bottom, 30)
                
                VStack(spacing: 20) {
                    TwoLineHeadingView(upperPart: "Welcome to FTHub", bottomPart: "Train Smart")
                    
                    HeadlineView(text: "Discover all your fitness apps in one place. Create workouts or enter one of our custom fitness programs")
                }
                .padding(.bottom, 30)
                .padding(.horizontal)
                
                Button(action: {
                    withAnimation(.easeOut) {
                        tutorialStarted = true
                    }
                }, label: {
                    Text("Start")
                        .padding(.vertical, 10)
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
                .padding(.horizontal, 30)
                .padding(.vertical)
            }
            .toolbar {
                Button(action: {
                    variables[0].showTutorial = false
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
