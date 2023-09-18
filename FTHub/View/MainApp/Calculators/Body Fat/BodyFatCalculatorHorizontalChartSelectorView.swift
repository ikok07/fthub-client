//
//  BodyFatCalculatorHorizontalChartSelectorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.09.23.
//

import SwiftUI

struct BodyFatCalculatorHorizontalChartSelectorView: View {
    var body: some View {
        VStack(spacing: 5) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 12, height: 40)
        }
        .foregroundStyle(.white)
        .shadow(color: .textfieldBg.opacity(0.7), radius: 6, x: 2, y: 2)
    }
}

#Preview {
    BodyFatCalculatorHorizontalChartSelectorView()
        .preferredColorScheme(.dark)
}
