//
//  VerticalNumberSelectorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct VerticalNumberSelectorView: View {
    @EnvironmentObject private var setupController: SetupController
    
    @State var activeHeight: Double = 270
    @State var userHeight: Double = 180
    
    var body: some View {
        ZStack {
            VStack {
                Text(setupController.units == .metric ? "\(Int(userHeight)) cm" : "\(Int(0.3937 * userHeight)) inch")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 30)
                ZStack {
                    VStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 120, height: activeHeight)
                            .foregroundStyle(K.Gradients.mainGradient.opacity(0.75))
                            .clipped()
                    }
                }
                .frame(width: 120, height: 400)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            let position = value.location.y
                            let newHeight = Double(400 - Int(position))
                            if newHeight < 60 {
                                activeHeight = 60
                            } else if newHeight > 400 {
                                activeHeight = 400
                            } else {
                                activeHeight = newHeight
                                userHeight = 120 + (activeHeight - 60) / 340 * 120
                            }
                            setupController.height = Int(userHeight)
                            
                        })
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.customGray)
                }
            }
            
            HStack {
                Spacer()
                VStack(spacing: 80) {
                    Text(setupController.units == .metric ? "230 cm" : "90 inch")
                        .foregroundStyle(.textGray)
                        .fontWeight(.semibold)
                    Text(setupController.units == .metric ? "190 cm" : "75 inch")
                        .foregroundStyle(.textGray)
                        .fontWeight(.semibold)
                    Text(setupController.units == .metric ? "160 cm" : "63 inch")
                        .foregroundStyle(.textGray)
                        .fontWeight(.semibold)
                    Text(setupController.units == .metric ? "120 cm" : "47 inch")
                        .foregroundStyle(.textGray)
                        .fontWeight(.semibold)
                }
            }
            .padding(.top, 40)
        }
        .frame(width: 260)
    }
}

#Preview {
    VerticalNumberSelectorView()
        .environmentObject(SetupController())
}
