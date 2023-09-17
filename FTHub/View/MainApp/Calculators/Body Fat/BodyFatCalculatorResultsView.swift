//
//  BodyFatCalculatorResultsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.09.23.
//

import SwiftUI

struct BodyFatCalculatorResultsView: View {
    
    var result: Double
    
    var body: some View {
        VStack(spacing: 10) {
            CalculatorResultsLabelView(offsetX: 0, offsetY: 0, result: result, unit: "%", invalid: result < 0 || result > 50 ? true : false)
            
            BodyFatCalculatorHorizontalChartView()
        }
        .frame(height: 150)
        .onChange(of: result) { oldValue, newValue in
            print(result)
        }
    }
}

#Preview {
    BodyFatCalculatorResultsView(result: 24.1)
        .padding()
}
