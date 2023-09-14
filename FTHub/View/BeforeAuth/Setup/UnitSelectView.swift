//
//  UnitSelectView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI
import SwiftData

struct UnitSelectView: View {
    
    @Environment(SetupController.self) private var setupController
    
    @State var activeUnits: Unit = .metric
    
    @Query private var user: [User]
    
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
                        if let user = user.first {
                            user.details?.units = .metric
                        }
                    }
                }, label: {
                    Text("Metric")
                        .foregroundStyle(activeUnits == .metric ? .white : .textGray)
                        .padding(EdgeInsets(top: 9, leading: 0, bottom: 9, trailing: 0))
                })
                .buttonStyle(activeUnits == .metric ? CTAButtonStyle(gradient: K.Gradients.mainGradient) : CTAButtonStyle(gradient: K.Gradients.clearGradient))
                
                Button(action: {
                    withAnimation {
                        setupController.units = .imperial
                        activeUnits = .imperial
                        if let user = user.first {
                            user.details?.units = .imperial
                        }
                    }
                }, label: {
                    Text("Imperial")
                        .foregroundStyle(activeUnits == .imperial ? .white : .textGray)
                        .padding(EdgeInsets(top: 9, leading: 0, bottom: 9, trailing: 0))
                })
                .buttonStyle(activeUnits == .imperial ? CTAButtonStyle(gradient: K.Gradients.mainGradient) : CTAButtonStyle(gradient: K.Gradients.clearGradient))
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onAppear {
                if let user = user.first {
                    activeUnits = user.details?.units ?? .metric
                }
            }
        }
        .padding()
    }
}

#Preview {
    UnitSelectView()
        .environment(SetupController())
}
