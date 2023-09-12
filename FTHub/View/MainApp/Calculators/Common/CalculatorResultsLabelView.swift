//
//  CalculatorResultsLabelView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 11.09.23.
//

import SwiftUI

struct CalculatorResultsLabelView: View {

    let offsetX: CGFloat
    let offsetY: CGFloat
    
    let result: Double
    var decimals: Int = 1
    var unit: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Your Results")
                .foregroundStyle(.textGray)
                .font(.headline)
                .fontWeight(.bold)
            
            HStack {
                Text("\(String(format: "%.\(decimals)f", result))")
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .contentTransition(.numericText())
                
                Text("\(unit)")
                    .font(.system(size: 40))
            }
        }
        .offset(x: offsetX, y: offsetY)
    }
}

#Preview {
    CalculatorResultsLabelView(offsetX: 0, offsetY: 0, result: 1480, decimals: 0, unit: "kcal")
}
