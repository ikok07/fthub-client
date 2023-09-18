//
//  BodyFatCalculatorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.09.23.
//

import SwiftUI

struct BodyFatCalculatorView: View {
    
    @State private var showResult: Bool = false
    @State private var result: Double = 0
    
    @State private var gender: Gender = .Male
    @State var age: String = ""
    @State var weight: String = ""
    @State var height: String = ""
    @State var waist: String = ""
    @State var neck: String = ""
    @State var hip: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CalculatorGenderSelector(activeGender: $gender)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 30)
                
                BodyFatCalculatorInputsView(result: $result, showResult: $showResult, gender: $gender, age: $age, weight: $weight, height: $height, waist: $waist, neck: $neck, hip: $hip)
                    .padding(.horizontal, 30)
                
                if showResult {
                    BodyFatCalculatorResultsView(result: result)
                        .padding(.top, 30)
                        .padding(.horizontal, 30)
                }
            }
            .navigationTitle("Body Fat Calculator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BodyFatCalculatorView()
}
