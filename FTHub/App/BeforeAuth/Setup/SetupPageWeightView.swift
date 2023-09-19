//
//  SetupWeightPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI
import HorizontalNumberPicker
import SwiftUIGauge
import SwiftData

struct SetupPageWeightView: View {
    
    @Environment(SetupController.self) private var setupController
    
    @State private var selectedWeight: Int = K.UserDetails.minWeight
    @State private var percentage: Double = 0
    @State private var gaugeText: String = ""
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    
    func updateText() {
        withAnimation(.bouncy) {
            gaugeText = setupController.units == .metric ? "\(selectedWeight) kg" : "\(Int(Double(selectedWeight) * 2.20462)) lbs"
        }
    }
    
    var body: some View {
        VStack {
            UnitSelectView()
                .padding(.top, 50)
            
            TwoLineHeadingView(upperPart: "What about", bottomPart: "your weight")
            
            ZStack {
                GaugeView(percentage: $percentage, width: UIScreen.main.bounds.width - 80, backgroundArcGradient: K.Gradients.lightGrayGradient, arrowLength: CGFloat(100), arrowAnchorMainCircleGradient: K.Gradients.mainGradient)
                    .padding(.horizontal)
                
                VStack {
                    Text(setupController.units == .metric ? "kg" : "lbs")
                        .font(.title3)
                        .fontWeight(.bold)
                        .contentTransition(.numericText())
                    Text(setupController.units == .metric ? "\(selectedWeight)" : "\(Int(Double(selectedWeight) * K.Units.kgToLbs))")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .contentTransition(.numericText(value: Double(selectedWeight)))
                }
                .animation(.bouncy, value: selectedWeight)
                .offset(y: 110)
            }
                
            HorizontalPickerView(value: $selectedWeight, selectorGradient: K.Gradients.mainGradient, minValue: K.UserDetails.minWeight, maxValue: K.UserDetails.maxWeight, startValue: 80)
                .offset(y: -65)
//                .padding(.horizontal)
            
            Button(action: {
                user[0].userDetails?.setupActivePage += 1
                user[0].userDetails?.weight = selectedWeight
                setupController.weight = selectedWeight
                setupController.activePage += 1
                try? context.save()
            }, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding(.horizontal)
            .offset(y: -65)
            
            Spacer()
        }
        .onChange(of: selectedWeight) { _, _ in
            withAnimation(.linear) {
                percentage = Double(selectedWeight - K.UserDetails.minWeight) / Double(K.UserDetails.maxWeight - K.UserDetails.minWeight)
            }
            updateText()
        }
        .onChange(of: setupController.units, { _, _ in
            updateText()
        })
        .onAppear {
            updateText()
        }
    }
}

#Preview {
    SetupPageWeightView()
        .environment(SetupController())
}
