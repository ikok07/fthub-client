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
    
    let invalid: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Your Result")
                .foregroundStyle(.textGray)
                .font(.headline)
                .fontWeight(.bold)
            
            HStack(alignment: .bottom, spacing: 5) {
                Text(invalid ? "Invalid" : "\(String(format: "%.\(decimals)f", result))")
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .contentTransition(.numericText())
                
                Text(invalid ? "" : "\(unit)")
                    .font(.system(size: 20))
                    .padding(.bottom, 10)
            }
        }
        .offset(x: offsetX, y: offsetY)
    }
}

#Preview {
    CalculatorResultsLabelView(offsetX: 0, offsetY: 0, result: 1480, decimals: 0, unit: "", invalid: true)
}
