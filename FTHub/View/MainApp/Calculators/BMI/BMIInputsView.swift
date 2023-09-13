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
    
    @State private var autofill: Bool = false
    
    @Binding var gender: Gender
    @Binding var weight: String
    @Binding var height: String
    @Binding var result: Double
    
    
    
    var body: some View {
        VStack {
            
            VStack(spacing: 20) {
                CustomInputField(icon: "scalemass.fill", unit: user.first?.details?.units == .metric ? "kg" : "lb", placeholder: "Weight", numpad: true, text: $weight)
                CustomInputField(icon: "arrow.up.and.down", unit: user.first?.details?.units == .metric ? "cm" : "in", placeholder: "Height", numpad: true, text: $height)
            }
            .padding()
            
            VStack(spacing: 10) {
                Button(action: calculate, label: {
                    Text("Calculate")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
                .padding(.horizontal)
                
                
                AutofillButtonView(autofill: $autofill, action: toggleAutofill)
            }
            .padding(.top)
        }
        .onChange(of: [gender.rawValue, weight, height]) { oldValue, newValue in
            if let user = user.first, user.details != nil {
                if newValue[0] != user.details!.gender?.rawValue || newValue[1] != String(user.details!.weight!) || newValue[2] != String(user.details!.height!) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        autofill = false
                    }
                }
            }
        }
    }
    
    func toggleAutofill() {
        withAnimation {
            autofill = true
        }
        if let user = user.first {
            if user.details?.units == .imperial {
                print("test")
                weight = String(format: "%.1f", Double((user.details?.weight!)!) * K.Units.kgToLbs)
                height = String(format: "%.1f", Double((user.details?.height!)!) * K.Units.cmToInch)
                print(weight, height)
            } else {
                weight = String((user.details?.weight!)!)
                height = String((user.details?.height!)!)
            }
        }
    }
    
    func calculate() {
        print(weight, height)
        if let user = user.first {
            withAnimation {
                result = BMIController.calculateBMI(units: user.details?.units ?? .metric, weight: Double(self.weight)! , height: Double(self.height)!)
            }
        }
    }
}

#Preview {
    BMIInputsView(gender: .constant(.Male), weight: .constant(""), height: .constant(""), result: .constant(25))
        .padding()
}
