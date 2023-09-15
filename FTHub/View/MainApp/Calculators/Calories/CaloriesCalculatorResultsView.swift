//
//  CaloriesCalculatorResultsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import SwiftUI
import SwiftUICustomizablePicker

enum CaloriesCalculatorResultOption: String, CaseIterable, Codable {
    case MaintainWeight, LoseWeight
}

struct CaloriesCalculatorResultsView: View {
    
    let result: Double
    
    var body: some View {
        VStack(spacing: 30) {
            CalculatorResultsLabelView(offsetX: 0, offsetY: 0, result: result, decimals: 0, unit: "kcal", invalid: false)
        }
    }
}

#Preview {
    CaloriesCalculatorResultsView(result: 1480)
        .padding()
}
