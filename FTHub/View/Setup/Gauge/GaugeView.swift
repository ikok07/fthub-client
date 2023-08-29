//
//  GaugeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct GaugeView: View {
    
    @Binding var percentage: Double
    @Binding var text: String
    
    func calcPercentage() -> CGFloat {
        return 0.1 + percentage * 0.7
    }
    
    var body: some View {
        ZStack() {
            Circle()
                .trim(from: 0.2, to: 0.8)
                .stroke(K.Gradients.grayGradient, style: StrokeStyle(lineWidth: 30, lineCap: .round))
                .frame(width: 300)
                .rotationEffect(.degrees(90))
            
            Circle()
                .trim(from: 0.2, to: calcPercentage())
                .stroke(K.Gradients.mainGradient, style: StrokeStyle(lineWidth: 30, lineCap: .round))
                .frame(width: 300)
                .rotationEffect(.degrees(90))

                Text(text)
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .offset(y: -20)
                    .contentTransition(.numericText())

        }
    }
}

#Preview {
    GaugeView(percentage: .constant(0.2), text: .constant("45 kg"))
}
