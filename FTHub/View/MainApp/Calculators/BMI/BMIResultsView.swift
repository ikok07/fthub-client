//
//  BMIResultsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI
import SwiftUIGauge

struct BMIResultsView: View {
    
    var result: Double
    
    var body: some View {
        VStack {
            BMIArcShapeView(value: result, width: 250, borderWidth: 30, arrowLength: 80)
                .offset(y: 75)
            
            CalculatorResultsLabelView(offsetX: 0, offsetY: 10, result: result)
        }
        .frame(height: 250)
    }
}

#Preview {
    BMIResultsView(result: 20.1)
}
