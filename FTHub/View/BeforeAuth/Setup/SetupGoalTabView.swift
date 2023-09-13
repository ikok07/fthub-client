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
                AnyView(GoalTabViewItem(active: selectedGoal == .WeightLoss ? true : false, header: "Normal", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            selectedGoal = .WeightLoss
                        }
                    }
                ),
                AnyView(GoalTabViewItem(active: selectedGoal == .Balance ? true : false, header: "Balance", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            selectedGoal = .Balance
                        }
                    }
                ),
                AnyView(GoalTabViewItem(active: selectedGoal == .MuscleBuilding ? true : false, header: "Max", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            selectedGoal = .MuscleBuilding
                        }
                    }
                )
            ]
        }
    }
}

#Preview {
    SetupGoalTabView(selectedGoal: .constant(.Balance))
}
