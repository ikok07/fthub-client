//
//  BodyFatCalculatorHorizontalChartView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.09.23.
//

import SwiftUI

struct BodyFatCalculatorHorizontalChartView: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    HStack(spacing: 0) {
                        Color.arc1
                            .frame(width: geometry.size.width * 0.04)
                        Color.arc2
                            .frame(width: geometry.size.width * 0.12)
                        Color.arc3
                            .frame(width: geometry.size.width * 0.24)
                        Color.arc4
                            .frame(width: geometry.size.width * 0.20)
                        Color.arc1
                            .frame(width: geometry.size.width * 0.40)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding()
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                
                    BodyFatCalculatorHorizontalChartSelectorView()
                        .position(x: geometry.size.width * 0.4, y: geometry.size.height / 2)
                }
            }
        }
        .frame(maxHeight: 50)
    }
}

#Preview {
    BodyFatCalculatorHorizontalChartView()
        .padding()
}
