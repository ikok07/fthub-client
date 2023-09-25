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
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    var body: some View {
        VStack {
            Text("Preferred units".uppercased())
                .font(.title2)
                .fontWeight(.regular)
            
            HStack {
                Button(action: {
                    withAnimation {
                        setupController.units = .metric
                        activeUnits = .metric
                        user[0].userDetails?.units = "metric"
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
                        user[0].userDetails?.units = "imperial"
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
                #warning("Uncomment")
//                activeUnits = Unit(rawValue: user[0].userDetails?.units ?? "metric") ?? .metric
            }
        }
        .padding()
    }
}

#Preview {
    UnitSelectView()
        .environment(SetupController())
}
