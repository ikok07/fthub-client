//
//  CaloriesCalculatorResultsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import SwiftUI

enum CaloriesCalculatorResultOption: String, CaseIterable, Codable {
    case MildWeightLoss, MaintainWeight, WeightLoss
}

struct CaloriesCalculatorResultsView: View {
    
    @Binding var selectedOption: CaloriesCalculatorResultOption
    
    let result: Double
    
    var body: some View {
        VStack {
            
            CalculatorResultsLabelView(offsetX: 0, offsetY: 0, result: result, decimals: 0, unit: "kcal", invalid: false)
            
            Picker("", selection: $selectedOption) {
                ForEach(CaloriesCalculatorResultOption.allCases, id: \.self) { option in
                    Text("\(option.rawValue)".camelCaseToWords())
                        .contentTransition(.numericText())
                        .tag(option)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    CaloriesCalculatorResultsView(selectedOption: .constant(.MaintainWeight), result: 1480)
        .padding()
}
