//
//  SetupPageGoalView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI

enum FitnessGoal: String, CaseIterable {
    case loseWeight, buildMuscles, gainMass
}

struct SetupPageGoalView: View {
    
    @EnvironmentObject private var setupController: SetupController
    
    @State private var selectedGoal: FitnessGoal = .buildMuscles
    
    var body: some View {
        VStack {
            TwoLineHeadingView(upperPart: "What is", bottomPart: "your goal")
                .padding(.top)
            
            Image("setup3")
                .resizable()
                .scaledToFit()
            
            SetupGoalTabView(selectedGoal: $selectedGoal)
            
            Button(action: {
                setupController.goal = selectedGoal
                setupController.activePage += 1
            }, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
        }
    }
}

#Preview {
    SetupPageGoalView()
}
