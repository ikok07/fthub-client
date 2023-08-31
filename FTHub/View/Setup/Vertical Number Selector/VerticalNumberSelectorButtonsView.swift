//
//  VerticalNumberSelectorButtonsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 30.08.23.
//

import SwiftUI

struct VerticalNumberSelectorButtonsView: View {
    
    @Binding var percentage: Double
    @Binding var userHeight: Double?
    let minValue: Double
    let maxValue: Double
    
    var body: some View {
        HStack {
            VStack(spacing: 15) {
                Button(action: {
                    if percentage < 1 {
                        withAnimation(.bouncy) {
                            percentage += 0.1
                            userHeight = 120 + (percentage * (maxValue - minValue))
                            if userHeight != nil && userHeight! > 220 {
                                percentage = 1
                                userHeight = 220
                            }
                        }
                    }
                }, label: {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(K.Gradients.mainGradient.opacity(0.75))
                        .font(.title)
                        .fontWeight(.semibold)
                })
                
                Button(action: {
                    if percentage > 0 {
                        withAnimation(.bouncy) {
                            percentage -= 0.1
                            userHeight = 120 + (percentage * (maxValue - minValue))
                            if userHeight != nil && userHeight! < 120 {
                                percentage = 0.0175
                                userHeight = 120
                            }
                        }
                    }
                }, label: {
                    Image(systemName: "minus.circle")
                        .foregroundStyle(K.Gradients.mainGradient.opacity(0.75))
                        .font(.title)
                        .fontWeight(.semibold)
                })
            }
            .offset(x: -40)
            Spacer()
        }
        .frame(width: 120, height: 400)
    }
}

#Preview {
    VerticalNumberSelectorButtonsView(percentage: .constant(0.3), userHeight: .constant(120), minValue: 120, maxValue: 240)
}
