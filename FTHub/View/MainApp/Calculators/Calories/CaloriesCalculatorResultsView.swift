//
//  CaloriesCalculatorResultsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import SwiftUI
import HorizontalNumberPicker

struct CaloriesCalculatorResultsView: View {
    
    @Binding var weightPerWeek: Double
    @State private var weightPerWeekInt: Int = 0
    let result: Double
    
    var body: some View {
        VStack(spacing: 5) {
            CalculatorResultsLabelView(offsetX: 0, offsetY: 0, result: result, decimals: 0, unit: "kcal", invalid: false)
            
            VStack(spacing: 0) {
                HorizontalPickerView(value: $weightPerWeekInt, selectorGradient: K.Gradients.mainGradient, minValue: -100, maxValue: 100, startValue: 0)
                HStack {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.footnote)
                        Text("Lose Weight")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    Text("\(String(format: "%.2f", weightPerWeek)) kg/week")
                        .foregroundStyle(weightPerWeek >= 0 ? K.Gradients.mainGradient : K.Gradients.redGradient)
                    Spacer()
                    HStack {
                        Text("Gain Weight")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.right")
                            .font(.footnote)
                    }
                }
                .padding(.horizontal, 30)
                .onChange(of: weightPerWeekInt) { oldValue, newValue in
                    weightPerWeek = Double(weightPerWeekInt) / 100
                }
            }
        }
    }
}

#Preview {
    CaloriesCalculatorResultsView(weightPerWeek: .constant(0), result: 1480)
}
