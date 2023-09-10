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
    
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                CalculatorGenderSelector(activeGender: $activeGender)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                BMIInputsView(age: $age, weight: $weight, height: $height)
            }
            .toolbar {
                Button(action: { isPresented = false }, label: {
                    Text("Back")
                })
            }
        }
        .navigationTitle("BMI Calculator")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BMICalculatorView(isPresented: .constant(true))
}
