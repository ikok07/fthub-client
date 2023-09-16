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
            NavigationLink(destination: CaloriesCalculatorView()) {
                CalculatorRowView(icon: "flame.fill", name: "Calories")
            }
            
            NavigationLink(destination: BMICalculatorView()) {
                CalculatorRowView(icon: "gauge.with.dots.needle.67percent", name: "BMI")
            }
            
            NavigationLink(destination: BodyFatCalculatorView()) {
                CalculatorRowView(icon: "drop.degreesign.fill", name: "Body Fat")
            }
        }
    }
}

#Preview {
    AllCalculatorsListView()
        .padding()
}
