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
    
    @State private var autofill: Bool = false
    
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
            
            AutofillButtonView(autofill: $autofill)
            
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
        .onChange(of: autofill, { oldValue, newValue in
            if newValue {
                enableAutoFill()
            }
        })
        .onChange(of: [self.gender.rawValue, self.age, self.weight, self.height]) { oldValue, newValue in
            if let user = user.first, user.details != nil {
                
                let savedWeight: String = String(user.details!.weight!)
                let savedWeightLbs: String = String(format: "%.1f", Double(user.details!.weight!) * K.Units.kgToLbs)
                
                let savedHeight: String = String(user.details!.height!)
                let savedHeightInches: String = String(format: "%.1f", Double(user.details!.height!) * K.Units.cmToInch)
                
                if newValue[0] != user.details!.gender!.rawValue || newValue[1] != String(user.details!.age!) || newValue[2] != (user.details!.units == .metric ? savedWeight : savedWeightLbs) || newValue[3] != (user.details!.units == .metric ? savedHeight : savedHeightInches) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        autofill = false
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
    
    func enableAutoFill() {
        if let user = user.first, user.details != nil {
            withAnimation(.easeOut(duration: 0.2)) {
                autofill = true
                gender = user.details!.gender!
                age = String(user.details!.age!)
                weight = user.details!.units == .metric ? String(user.details!.weight!) : String(format: "%.1f", (Double(user.details!.weight!) * K.Units.kgToLbs))
                height = user.details!.units == .metric ? String(user.details!.height!) : String(format: "%.1f", (Double(user.details!.height!) * K.Units.cmToInch))
            }
        }
    }
    
}

#Preview {
    BodyFatCalculatorInputsView(result: .constant(21.1), showResult: .constant(true), gender: .constant(.Female), age: .constant(""), weight: .constant(""), height: .constant(""), waist: .constant(""), neck: .constant(""), hip: .constant(""))
        .padding()
}
