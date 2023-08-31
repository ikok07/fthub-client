//
//  VerticalNumberSelectorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct VerticalNumberSelectorView: View {
    @EnvironmentObject private var setupController: SetupController
    
    @State private var percentage: Double = 0.6
    

    @State var userHeight: Double?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            VerticalNumberSelectorButtonsView(percentage: $percentage, userHeight: $userHeight, minValue: Double(K.UserDetails.minHeight), maxValue: Double(K.UserDetails.maxHeight))
            
            VStack {
                Text(setupController.units == .metric ? "\(Int(userHeight ?? 0)) cm" : "\(String(format: "%5.1f", 0.3937 * (userHeight ?? 0))) inch")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 30)
                    .contentTransition(.numericText())
                    .animation(.bouncy, value: userHeight)
                ZStack {
                    VStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: percentage * 20)
                            .frame(width: 120, height: percentage * 400)
                            .foregroundStyle(K.Gradients.mainGradient.opacity(0.75))
                            .clipped()
                    }
                }
                .frame(width: 120, height: 400)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .sensoryFeedback(.impact, trigger: userHeight)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            let position = value.location.y
                            let newHeight = Double(400 - Int(position))
                            if newHeight < 7 {
                                percentage = 0.0175
                            } else if newHeight > 400 {
                                percentage = 1
                            } else {
                                percentage = newHeight / 400
                                userHeight = 120 + (percentage * (Double(K.UserDetails.maxHeight) - Double(K.UserDetails.minHeight)))
                            }
                            setupController.height = Int(userHeight ?? 0)
                            
                        })
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.customGray)
                }
            }
            
            VerticalNumberSelectorStepsLabelsView()
            
        }
        .onAppear {
            userHeight = 120 + (percentage * (Double(K.UserDetails.maxHeight) - Double(K.UserDetails.minHeight)))
        }
        .frame(width: 260)
    }
}

#Preview {
    VerticalNumberSelectorView()
        .environmentObject(SetupController())
}
