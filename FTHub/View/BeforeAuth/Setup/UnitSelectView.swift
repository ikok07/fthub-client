//
//  UnitSelectView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct UnitSelectView: View {
    
    @EnvironmentObject private var setupController: SetupController
    
    @State var activeUnits: Unit = .metric
    
    var body: some View {
        VStack {
            Text("Preffered units".uppercased())
                .font(.title2)
                .fontWeight(.regular)
            
            HStack {
                Button(action: {
                    withAnimation {
                        setupController.units = .metric
                        activeUnits = .metric
                    }
                }, label: {
                    Text("Metric")
                        .foregroundStyle(activeUnits == .metric ? .white : .textGray)
                        .padding(EdgeInsets(top: 7, leading: 0, bottom: 7, trailing: 0))
                })
                .buttonStyle(activeUnits == .metric ? CTAButtonStyle(gradient: K.Gradients.mainGradient) : CTAButtonStyle(gradient: K.Gradients.clearGradient))
                
                Button(action: {
                    withAnimation {
                        setupController.units = .imperial
                        activeUnits = .imperial
                    }
                }, label: {
                    Text("Imperial")
                        .foregroundStyle(activeUnits == .imperial ? .white : .textGray)
                        .padding(EdgeInsets(top: 7, leading: 0, bottom: 7, trailing: 0))
                })
                .buttonStyle(activeUnits == .imperial ? CTAButtonStyle(gradient: K.Gradients.mainGradient) : CTAButtonStyle(gradient: K.Gradients.clearGradient))
            }
            .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(.customGray)
            }
        }
        .padding()
    }
}

#Preview {
    UnitSelectView()
}
