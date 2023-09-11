//
//  BMIInputsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI
import SwiftData

struct BMIInputsView: View {
    
    @Query private var user: [User]
    
    @Binding var weight: Double
    @Binding var height: Double
    @Binding var result: Double
    
    var body: some View {
        VStack {
            
            VStack(spacing: 0) {
                CustomValueInputView(value: $weight, icon: "scalemass", name: "Weight", pickerWidth: user.first?.details?.units == .metric ? 95 : 120) {
                    Picker("", selection: $weight) {
                        ForEach((K.UserDetails.minWeight)...K.UserDetails.maxWeight, id: \.self) { i in
                            Text(user.first?.details?.units == .metric ? "\(i) kg" : "\(String(format: "%.1f", Double(i) * K.Units.kgToLbs)) lbs")
                                .tag(Double(i))
                        }
                    }
                }
                CustomValueInputView(value: $height, icon: "arrow.up.and.down", name: "Height", pickerWidth: user.first?.details?.units == .metric ? 90 : 125) {
                    Picker("", selection: $height) {
                        ForEach(K.UserDetails.minHeight...K.UserDetails.maxHeight, id: \.self) { i in
                            Text(user.first?.details?.units == .metric ? "\(i) cm" : "\(String(format: "%.1f", Double(i) * K.Units.cmToInch)) inch.")
                                .tag(Double(i))
                        }
                    }
                }
            }
            .padding()
            
            Button(action: calculate, label: {
                Text("Calculate")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
        }
    }
    
    func calculate() {
        print(weight, height)
        if let user = user.first {
            withAnimation {
                result = BMIController.calculateBMI(units: user.details?.units ?? .metric, weight: Double(self.weight) ?? 40, height: Double(self.height) ?? 120)
            }
        }
    }
}

#Preview {
    BMIInputsView(weight: .constant(0), height: .constant(0), result: .constant(25))
        .padding()
}
