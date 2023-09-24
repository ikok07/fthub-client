//
//  SettingsFitnessDataView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import SwiftUI
import SwiftData

struct SettingsFitnessDataView: View {
    
    @FocusState private var isActive: Bool
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    
    @Binding var height: String
    @Binding var weight: String
    @Binding var workoutsPerWeek: Int
    @Binding var goal: FitnessGoal
    @Binding var units: Unit
    
    @State private var contentLoaded: Bool = false
    
    var body: some View {
        SettingsGroupView(name: "Fitness Data") {
            SettingsInputRowView(name: "Height") {
                TextField("", text: $height)
                    .frame(width: 75)
                    .multilineTextAlignment(.trailing)
                    .tint(.text)
                    .contentTransition(.numericText())
                    .keyboardType(.decimalPad)
                    .focused($isActive)
                
                Text(self.units == .metric ? "cm" : "inch.")
                    .tint(.text)
                    .contentTransition(.numericText())
            }
            SettingsInputRowView(name: "Weight") {
                TextField("", text: $weight)
                    .frame(width: 75)
                    .multilineTextAlignment(.trailing)
                    .tint(.text)
                    .keyboardType(.numberPad)
                    .focused($isActive)
                
                Text(self.units == .metric ? "kg" : "lbs")
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
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        isActive = false
                    }
                }
            }
        }
        .onChange(of: [height, weight], { _, _ in
            height = height.replacingOccurrences(of: ",", with: ".")
            weight = weight.replacingOccurrences(of: ",", with: ".")
        })
        .onChange(of: units) { oldValue, newValue in
            if contentLoaded {
                withAnimation(.bouncy) {
                    if newValue == .metric && oldValue == .imperial {
                        self.height = String(format: "%.0f", Double(self.height)! / K.Units.cmToInch)
                        self.weight = String(format: "%.0f", Double(self.weight)! / K.Units.kgToLbs)
                    } else if newValue == .imperial && oldValue == .metric {
                        self.height = String(format: "%.1f", Double(self.height)! * K.Units.cmToInch)
                        self.weight = String(format: "%.0f", Double(self.weight)! * K.Units.kgToLbs)
                    }
                }
            }
            contentLoaded = true
        }
        .onAppear {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                if self.units == .metric {
                    contentLoaded = true
                }
            }
        }
    }
}

#Preview {
    SettingsFitnessDataView(height: .constant("178"), weight: .constant("62"), workoutsPerWeek: .constant(4), goal: .constant(.Balance), units: .constant(.metric))
}
