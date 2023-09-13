//
//  BMICalculatorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct BMICalculatorView: View {
    
    @Binding var isPresented: Bool
    
    @State private var activeGender: Gender = .Male
    
    @State private var weight: String = ""
    @State private var height: String = ""
    
    @State private var result: Double = 11
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("BMI Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                CalculatorGenderSelector(activeGender: $activeGender)
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                BMIInputsView(gender: $activeGender, weight: $weight, height: $height, result: $result)
                
                Spacer()
                
                if result > 11 {
                    BMIResultsView(result: result)
                }
            }
            .toolbar {
                Button(action: { isPresented = false }, label: {
                    Text("Done")
                        .fontWeight(.semibold)
                })
            }
            .padding()
        }
    }
}

#Preview {
    BMICalculatorView(isPresented: .constant(true))
}
