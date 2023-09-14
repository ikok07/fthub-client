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
    
    var invalid: Bool {
        if result > 46 || result < 13 {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        VStack {
            BMIArcShapeView(value: result > 46 || result < 13 ? 46 : result, width: 250, borderWidth: 30, arrowLength: 80)
                .offset(y: 75)
            
            CalculatorResultsLabelView(offsetX: 0, offsetY: 20, result: self.result, invalid: self.invalid)
        }
        .frame(height: 250)
    }
}

#Preview {
    BMIResultsView(result: 20.1)
}
