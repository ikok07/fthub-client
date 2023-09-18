//
//  BMICalculatorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct BMICalculatorView: View {
    
    @State private var activeGender: Gender = .Male
    
    @State private var weight: String = ""
    @State private var height: String = ""
    
    @State private var showResult: Bool = false
    @State private var result: Double = 15
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                CalculatorGenderSelector(activeGender: $activeGender)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                BMIInputsView(gender: $activeGender, weight: $weight, height: $height, result: $result, showResult: $showResult)
                
                Spacer()
                
                if showResult {
                    BMIResultsView(result: result)
                }
            }
            .navigationTitle("BMI Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

#Preview {
    BMICalculatorView()
}
