//
//  AllCalculatorsListView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct AllCalculatorsListView: View {
    
    @State private var caloriesCalculator: Bool = false
    @State private var bmiCalculator: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            CalculatorRowView(icon: "flame.fill", name: "Calories", destination: CaloriesCalculatorView(isPresented: $caloriesCalculator), isPresented: $caloriesCalculator)
            
            CalculatorRowView(icon: "gauge.with.dots.needle.67percent", name: "BMI", destination: BMICalculatorView(isPresented: $bmiCalculator), isPresented: $bmiCalculator)
        }
    }
}

#Preview {
    AllCalculatorsListView()
        .padding()
}
