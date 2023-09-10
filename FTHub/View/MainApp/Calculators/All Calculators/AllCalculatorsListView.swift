//
//  AllCalculatorsListView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct AllCalculatorsListView: View {
    
    @State private var calculatorPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            CalculatorRowView(icon: "gauge.with.dots.needle.67percent", name: "BMI", destination: BMICalculatorView(isPresented: $calculatorPresented), isPresented: $calculatorPresented)
        }
    }
}

#Preview {
    AllCalculatorsListView()
        .padding()
}
