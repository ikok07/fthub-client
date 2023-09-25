//
//  VerticalNumberSelectorStepsLabelsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 30.08.23.
//

import SwiftUI

struct VerticalNumberSelectorStepsLabelsView: View {
    
    @Environment(SetupController.self) private var setupController
    
    let height: Double
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                VStack {
                    Text(setupController.units == .metric ? "220 cm" : "\(Int(220 * 0.3937)) inches")
                        .fontWeight(.semibold)
                        .foregroundStyle(.textGray)
                        .position(x: setupController.units == .metric ? geometry.frame(in: .local).midX : geometry.frame(in: .local).midX + 10, y: geometry.frame(in: .local).minY + 20)
                        .contentTransition(.numericText())
                        .animation(.bouncy, value: setupController.units)

                    Text(setupController.units == .metric ? "170 cm": "\(Int(170 * 0.3937)) inches")
                        .fontWeight(.semibold)
                        .foregroundStyle(.textGray)
                        .offset(x: setupController.units == .metric ? 0 : 10)
                        .contentTransition(.numericText())
                        .animation(.bouncy, value: setupController.units)
                    
                    Text(setupController.units == .metric ? "120 cm" : "\(Int(120 * 0.3937)) inches")
                        .fontWeight(.semibold)
                        .foregroundStyle(.textGray)
                        .position(x: setupController.units == .metric ? geometry.frame(in: .local).midX : geometry.frame(in: .local).midX + 10, y: geometry.frame(in: .local).midY - (height / 11.43))
                        .contentTransition(.numericText())
                        .animation(.bouncy, value: setupController.units)
                }
                .position(x: geometry.frame(in: .local).maxX, y: geometry.frame(in: .local).midY)
            }
            .frame(width: 200, height: height)
        }
    }
}

#Preview {
    VerticalNumberSelectorStepsLabelsView(height: 300)
        .environment(SetupController())
}
