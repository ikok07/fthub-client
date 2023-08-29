//
//  SetupWeightPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI
import HorizontalNumberPicker

struct SetupWeightPageView: View {
    
    @EnvironmentObject private var setupController: SetupController
    
    @State private var selectedWeight: Int = 70
    @State private var percentage: Double = 0.5
    @State private var gaugeText: String = ""
    
    func updateText() {
        withAnimation(.bouncy) {
            gaugeText = setupController.units == .metric ? "\(selectedWeight) kg" : "\(Int(Double(selectedWeight) * 2.20462)) lbs"
        }
    }
    
    var body: some View {
        VStack {
            UnitSelectView()
            
            TwoLineHeadingView(upperPart: "What about", bottomPart: "your weight")
            
            GaugeView(percentage: $percentage, text: $gaugeText)
                .offset(y: 50)
                .padding(.bottom, 50)
            
            VStack(spacing: 0) {
                HorizontalPickerView(value: $selectedWeight, minValue: 20, maxValue: 140)
                GlowingTextView(text: "Choose height value")
            }
            Spacer()
            Button(action: {}, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
        }
        .padding()
        .onChange(of: selectedWeight) { oldValue, newValue in
            withAnimation {
                percentage = Double(selectedWeight) / 140
            }
            updateText()
        }
        .onChange(of: setupController.units, { oldValue, newValue in
            updateText()
        })
        .onAppear {
            updateText()
        }
    }
}

#Preview {
    SetupWeightPageView()
        .environmentObject(SetupController())
}
