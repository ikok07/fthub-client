//
//  SettingsFitnessDataView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import SwiftUI
import SwiftData

struct SettingsFitnessDataView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    @Binding var height: Int
    @Binding var weight: Int
    @Binding var workoutsPerWeek: Int
    @Binding var goal: FitnessGoal
    
    
    var body: some View {
        SettingsGroupView(name: "Fitness Data") {
            SettingsInputRowView(name: "Height") {
                Picker("", selection: $height) {
                    ForEach(120...220, id: \.self) { i in
                        Text(user[0].details?.units == .metric ? "\(i) cm" : "\(String(format: "%.2f", Double(i) * 0.3937)) inch")
                            .font(.body)
                            .fontWeight(.medium)
                    }
                }
                .tint(.text)
            }
            SettingsInputRowView(name: "Weight") {
                Picker("", selection: $weight) {
                    ForEach(40...180, id: \.self) { i in
                        Text(user[0].details?.units == .metric ? "\(i) kg" : "\(String(format: "%.1f", Double(i) * 2.2046226218488)) lbs")
                            .font(.body)
                            .fontWeight(.medium)
                    }
                }
                .tint(.text)
            }
            SettingsInputRowView(name: "Workouts") {
                Picker("", selection: $workoutsPerWeek) {
                    ForEach(2...7, id: \.self) { i in
                        Text("\(i) times/week")
                            .font(.body)
                            .fontWeight(.medium)
                            .tag(i)
                    }
                }
                .tint(.text)
            }
            SettingsInputRowView(name: "Goal") {
                Picker("", selection: $goal) {
                    Text("\(FitnessGoal.WeightLoss.rawValue)".camelCaseToWords())
                        .tag(FitnessGoal.WeightLoss)
                    Text("\(FitnessGoal.Balance.rawValue)")
                        .tag(FitnessGoal.Balance)
                    Text("\(FitnessGoal.MuscleBuilding.rawValue)".camelCaseToWords())
                        .tag(FitnessGoal.MuscleBuilding)
                }
                .tint(.text)
            }
        }
    }
}

#Preview {
    SettingsFitnessDataView(height: .constant(178), weight: .constant(62), workoutsPerWeek: .constant(4), goal: .constant(.Balance))
}
