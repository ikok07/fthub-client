//
//  SetupPageGoalView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI
import SwiftData

enum FitnessGoal: String, CaseIterable, Codable {
    case WeightLoss, Balance, MuscleBuilding
}

struct SetupPageGoalView: View {
    
    @EnvironmentObject private var setupController: SetupController
    
    @State private var selectedGoal: FitnessGoal = .Balance
    
    @Query private var user: [User]
    
    var body: some View {
        VStack {
            TwoLineHeadingView(upperPart: "What is", bottomPart: "your goal")
                .padding(.top)
            
            Image("setup3")
                .resizable()
                .scaledToFit()
            
            SetupGoalTabView(selectedGoal: $selectedGoal)
            
            Button(action: {
                if let user = user.first {
                    user.details?.setupActivePage += 1
                    user.details?.goal = selectedGoal
                }
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
