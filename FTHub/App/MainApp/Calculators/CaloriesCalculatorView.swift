//
//  CaloriesCalculatorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import SwiftUI
import SwiftData

struct CaloriesCalculatorView: View {
    
    @Query private var user: [User]
    
    @State private var showResult: Bool = false
    
    @State private var gender: Gender = .Male
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var activityLevel: ActivityLevel = .SelectActivity
    
    @State private var weightPerWeek: Double = 0
    @State private var result: Double = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                CalculatorGenderSelector(activeGender: $gender)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 30)
                
                CaloriesCalculatorInputView(showResult: $showResult, result: $result, weightPerWeek: self.$weightPerWeek, gender: $gender, age: $age, weight: $weight, height: $height, activityLevel: $activityLevel)
                    .padding(.horizontal, 30)
                
                if showResult {
                    CaloriesCalculatorResultsView(weightPerWeek: $weightPerWeek, result: result)
                        .padding(.top, 5)
                }
            }
            .navigationTitle("Calories Calculator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CaloriesCalculatorView()
}
