//
//  SetupWeightPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI
import HorizontalNumberPicker
import SwiftUIGauge

struct SetupPageWeightView: View {
    
    @EnvironmentObject private var setupController: SetupController
    
    @State private var selectedWeight: Int = K.UserDetails.minWeight
    @State private var percentage: Double = 0
    @State private var gaugeText: String = ""
    
    
    func updateText() {
        withAnimation(.bouncy) {
            gaugeText = setupController.units == .metric ? "\(selectedWeight) kg" : "\(Int(Double(selectedWeight) * 2.20462)) lbs"
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            UnitSelectView()
            
            TwoLineHeadingView(upperPart: "What about", bottomPart: "your weight")
            
            ZStack {
                GaugeView(percentage: $percentage, width: UIScreen.main.bounds.width - 50, backgroundArcGradient: K.Gradients.grayGradient, arrowLength: CGFloat(100), arrowAnchorMainCircleGradient: K.Gradients.mainGradient)
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
                .offset(y: -35)
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                setupController.weight = selectedWeight
                setupController.activePage += 1
            }, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
            .offset(y: -35)
        }
        .padding()
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
        .environmentObject(SetupController())
}
