//
//  BodyFatCalculatorInputsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 16.09.23.
//

import SwiftUI
import SwiftData

struct BodyFatCalculatorInputsView: View {
    
    @FocusState private var isActive: Bool
    
    @Query private var user: [User]
    
    @Binding var result: Double
    @Binding var showResult: Bool
    
    @Binding var gender: Gender
    @Binding var age: String
    @Binding var weight: String
    @Binding var height: String
    @Binding var waist: String
    @Binding var neck: String
    @Binding var hip: String
    
    var body: some View {
        VStack(spacing: 20) {
            CustomInputField(isActive: _isActive, icon: "calendar", unit: "years", placeholder: "Age", numpad: true, text: $age)
            
            CustomInputField(isActive: _isActive, icon: "scalemass.fill", unit: user.first?.details?.units == .metric ? "kg" : "lb", placeholder: "Weight", numpad: true, text: $weight)
            
            CustomInputField(isActive: _isActive, icon: "arrow.up.and.down", unit: user.first?.details?.units == .metric ? "cm" : "in", placeholder: "Height", numpad: true, text: $height)
            
            if gender == .Female {
                CustomInputField(isActive: _isActive, icon: "h.circle.fill", unit: user.first?.details?.units == .metric ? "cm" : "in", placeholder: "Hip", numpad: true, text: $hip)
            }
            
            HStack(spacing: 20) {
                CustomInputField(isActive: _isActive, icon: "arrow.circlepath", unit: user.first?.details?.units == .metric ? "cm" : "in", placeholder: "Waist", numpad: true, text: $waist)
                CustomInputField(isActive: _isActive, icon: "person.fill", unit: user.first?.details?.units == .metric ? "cm" : "in", placeholder: "Neck", numpad: true, text: $neck)
            }
            
            Button(action: calculate) {
                Text("Calculate")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        isActive = false
                    }
                }
            }
        }
    }
    
    func calculate() {
        if let user = user.first, user.details != nil {
            withAnimation {
                if CalculatorsCommonController.validate(age: self.age, weight: self.weight, height: self.height, hip: gender == .Female ? self.hip : nil, waist: self.waist, neck: self.neck) {
                    showResult = true
                    result = BodyFatCalculatorController.calculateFat(units: user.details!.units!, gender: self.gender, height: Double(self.height)!, neck: Double(self.neck)!, waist: Double(self.waist)!, hip: Double(self.hip) ?? 0)
                }
            }
        }
    }
    
}

#Preview {
    BodyFatCalculatorInputsView(result: .constant(21.1), showResult: .constant(true), gender: .constant(.Female), age: .constant(""), weight: .constant(""), height: .constant(""), waist: .constant(""), neck: .constant(""), hip: .constant(""))
        .padding()
}
