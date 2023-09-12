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
    
    @Binding var isPresented: Bool
    
    @State private var gender: Gender = .Male
    @State private var age: Double = 16
    @State private var weight: Double = 40
    @State private var height: Double = 120
    @State private var activityLevel: ActivityLevel = .Active
    
    @State private var result: Double = 0
    @State private var resultOption: CaloriesCalculatorResultOption = .MaintainWeight
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                Text("Calories Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                CalculatorGenderSelector(activeGender: $gender)
                    .padding(.top, 20)
                    .padding(.horizontal)
                
                CaloriesCalculatorInputView(result: $result, selectedOption: $resultOption, gender: $gender, age: $age, weight: $weight, height: $height, activityLevel: $activityLevel)
                
                CaloriesCalculatorResultsView(selectedOption: $resultOption, result: result)
                    .padding(.top)
            }
            .padding()
            .toolbar {
                Button(action: { isPresented = false }, label: {
                    Text("Done")
                        .fontWeight(.semibold)
                })
            }
        }
    }
}

#Preview {
    CaloriesCalculatorView(isPresented: .constant(true))
}
