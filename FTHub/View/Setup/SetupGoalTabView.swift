//
//  SetupGoalTabView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI

struct SetupGoalTabView: View {
    
    @State private var shownGoal: Int = 1
    @Binding var selectedGoal: FitnessGoal
    
    var body: some View {
        TeasingTabView(selectedTab: $shownGoal, spacing: 10) {
            [
                AnyView(GoalTabViewItem(active: selectedGoal == .loseWeight ? true : false, header: "Lose weight", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            selectedGoal = .loseWeight
                        }
                    }
                ),
                AnyView(GoalTabViewItem(active: selectedGoal == .buildMuscles ? true : false, header: "Build muscles", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            selectedGoal = .buildMuscles
                        }
                    }
                ),
                AnyView(GoalTabViewItem(active: selectedGoal == .gainMass ? true : false, header: "Gain Mass", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            selectedGoal = .gainMass
                        }
                    }
                )
            ]
        }
    }
}

#Preview {
    SetupGoalTabView(selectedGoal: .constant(.buildMuscles))
}
