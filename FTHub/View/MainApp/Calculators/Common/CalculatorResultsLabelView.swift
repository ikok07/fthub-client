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
    
    var body: some View {
        VStack {
            Text("Your Results")
                .foregroundStyle(.textGray)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(String(format: "%.1f", result))
                .font(.system(size: 48))
                .fontWeight(.bold)
                .contentTransition(.numericText())
        }
        .offset(x: offsetX, y: offsetY)
    }
}

#Preview {
    CalculatorResultsLabelView(offsetX: 0, offsetY: 0, result: 20.1)
}
