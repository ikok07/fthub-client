//
//  VerticalNumberSelectorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct VerticalNumberSelectorView: View {
    @Environment(SetupController.self) private var setupController
    
    @State private var percentage: Double = 0.6
    
    @Binding var userHeight: Double?
    
    var height: Double = 315
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            VerticalNumberSelectorButtonsView(percentage: $percentage, userHeight: $userHeight, minValue: Double(K.UserDetails.minHeight), maxValue: Double(K.UserDetails.maxHeight), height: self.height)
            
            VStack {
                Text(setupController.units == .metric ? "\(String(format: "%.0f", userHeight ?? 0)) cm" : "\(String(format: "%.1f", K.Units.cmToInch * (userHeight ?? 0))) inch")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                    .contentTransition(.numericText())
                    .animation(.bouncy, value: userHeight)
                ZStack {
                    VStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: percentage * 20)
                            .frame(width: 120, height: percentage * height)
                            .foregroundStyle(K.Gradients.mainGradient)
                            .clipped()
                    }
                }
                .frame(width: 120, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .sensoryFeedback(.impact, trigger: userHeight)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            let position = value.location.y
                            let newHeight = Double(height - Double(position))
                            if newHeight < 7 {
                                percentage = 0.0175
                            } else if newHeight > height {
                                percentage = 1
                            } else {
                                percentage = newHeight / height
                                userHeight = 120 + (percentage * (Double(K.UserDetails.maxHeight) - Double(K.UserDetails.minHeight)))
                            }
                            setupController.height = userHeight ?? 0
                            
                        })
                )
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            VerticalNumberSelectorStepsLabelsView(height: self.height)
            
        }
        .onAppear {
            userHeight = 120 + (percentage * (Double(K.UserDetails.maxHeight) - Double(K.UserDetails.minHeight)))
        }
        .frame(width: 260)
    }
}

#Preview {
    VerticalNumberSelectorView(userHeight: .constant(175))
        .environment(SetupController())
}
