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
    
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    @State private var autofill: Bool = false
    @State private var validations: [Bool?] = Array(repeating: false, count: 6)
    
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
        VStack(spacing: 0) {
            CustomInputField(isActive: _isActive, type: .age, icon: "calendar", unit: "years", placeholder: "Age", numpad: true, text: $age, validationResult: $validations[0])
            
            CustomInputField(isActive: _isActive, type: .weight, icon: "scalemass.fill", unit: user[0].userDetails?.units == "metric" ? "kg" : "lbs", placeholder: "Weight", numpad: true, text: $weight, validationResult: $validations[1])
            
            CustomInputField(isActive: _isActive, type: .height, icon: "arrow.up.and.down", unit: user[0].userDetails?.units == "metric" ? "cm" : "in", placeholder: "Height", numpad: true, text: $height, validationResult: $validations[2])
            
            if gender == .Female {
                CustomInputField(isActive: _isActive, type: .hip, icon: "h.circle.fill", unit: user[0].userDetails?.units == "metric" ? "cm" : "in", placeholder: "Hip", numpad: true, text: $hip, validationResult: $validations[3])
            }
            
            HStack(spacing: 20) {
                CustomInputField(isActive: _isActive, type: .waist, icon: "arrow.circlepath", unit: user[0].userDetails?.units == "metric" ? "cm" : "in", placeholder: "Waist", numpad: true, text: $waist, validationResult: $validations[gender == .Female ? 4 : 3])
                CustomInputField(isActive: _isActive, type: .neck, icon: "person.fill", unit: user[0].userDetails?.units == "metric" ? "cm" : "in", placeholder: "Neck", numpad: true, text: $neck, validationResult: $validations[gender == .Female ? 5 : 4])
            }
            
            AutofillButtonView(autofill: $autofill)
                .padding(.bottom)
            
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
            
            let savedWeight: String = String(user[0].userDetails!.weight)
            let savedWeightLbs: String = String(format: "%.1f", Double(user[0].userDetails!.weight) * K.Units.kgToLbs)
            
            let savedHeight: String = String(user[0].userDetails!.height)
            let savedHeightInches: String = String(format: "%.1f", Double(user[0].userDetails!.height) * K.Units.cmToInch)
            
            if newValue[0] != user[0].userDetails!.gender! || newValue[1] != String(user[0].userDetails!.age) || newValue[2] != (user[0].userDetails!.units == "metric" ? savedWeight : savedWeightLbs) || newValue[3] != (user[0].userDetails!.units == "metric" ? savedHeight : savedHeightInches) {
                withAnimation(.easeOut(duration: 0.2)) {
                    autofill = false
                }
            }
        }
    }
    
    func calculate() {
        print(validations)
        withAnimation {
            if validations == Array(repeating: false, count: 6) {
                if CalculatorsCommonController.validate(age: self.age, weight: self.weight, height: self.height, hip: gender == .Female ? self.hip : nil, waist: self.waist, neck: self.neck) {
                    showResult = true
                    result = BodyFatCalculatorController.calculateFat(units: Unit(rawValue: user[0].userDetails!.units!)!, gender: self.gender, height: Double(self.height)!, neck: Double(self.neck)!, waist: Double(self.waist)!, hip: Double(self.hip) ?? 0)
                }
            }
        }
    }
    
    func enableAutoFill() {
        withAnimation(.easeOut(duration: 0.2)) {
            autofill = true
            gender = Gender(rawValue: user[0].userDetails!.gender!)!
            age = String(user[0].userDetails!.age)
            weight = user[0].userDetails!.units == "metric" ? String(user[0].userDetails!.weight) : String(format: "%.1f", (Double(user[0].userDetails!.weight) * K.Units.kgToLbs))
            height = user[0].userDetails!.units == "metric" ? String(user[0].userDetails!.height) : String(format: "%.1f", (Double(user[0].userDetails!.height) * K.Units.cmToInch))
        }
    }
    
}

#Preview {
    BodyFatCalculatorInputsView(result: .constant(21.1), showResult: .constant(true), gender: .constant(.Female), age: .constant(""), weight: .constant(""), height: .constant(""), waist: .constant(""), neck: .constant(""), hip: .constant(""))
        .padding()
}
