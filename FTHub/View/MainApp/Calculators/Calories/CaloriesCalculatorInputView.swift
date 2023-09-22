//
//  CaloriesCalculatorInputView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import SwiftUI
import SwiftData
import SwiftUICustomizablePicker

enum ActivityLevel: String, Codable, CaseIterable {
    case SelectActivity, Light, Active, VeryActive, UltraActive
}

struct CaloriesCalculatorInputView: View {
    
    @FocusState private var isActive: Bool
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    @State private var autofill: Bool = false
    @State private var validations: [Bool?] = Array(repeating: false, count: 3)
    
    @Binding var showResult: Bool
    @Binding var result: Double
    @Binding var weightPerWeek: Double
    
    @Binding var gender: Gender
    @Binding var age: String
    @Binding var weight: String
    @Binding var height: String
    @Binding var activityLevel: ActivityLevel
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                
                CustomInputField(isActive: _isActive, type: .age, icon: "calendar", unit: "years", placeholder: "Age (min. 16 years)", numpad: true, text: $age, validationResult: $validations[0])
                
                CustomInputField(isActive: _isActive, type: .weight, icon: "scalemass.fill", unit: user.first?.userDetails?.units == "metric" ? "kg" : "lbs", placeholder: "Weight (min. \(user.first?.userDetails?.units == "metric" ? "40 kg" : "88 lbs"))", numpad: true, text: $weight, validationResult: $validations[1])
                
                CustomInputField(isActive: _isActive, type: .height, icon: "arrow.up.and.down", unit: user.first?.userDetails?.units == "metric" ? "cm" : "in", placeholder: "Height (min. \(user.first?.userDetails?.units == "metric" ? "120 cm" : "47 inches"))", numpad: true, text: $height, validationResult: $validations[2])
                
                CustomPickerRowView(icon: "figure.run") {
                    Picker("", selection: $activityLevel) {
                        ForEach(ActivityLevel.allCases, id: \.self) { level in
                            Text("\(level.rawValue)".camelCaseToWords())
                        }
                    }
                    .tint(activityLevel == .SelectActivity ? .textGray : .text)
                }
                
                AutofillButtonView(autofill: $autofill)
                    .padding(.top)
            }
            
            Button(action: calculate) {
                Text("Calculate")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding(.top)
            
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
        .onChange(of: [gender.rawValue, activityLevel.rawValue, age, weight, height]) { oldValue, newValue in
            let savedWeight: String = String(user[0].userDetails!.weight)
            let savedWeightLbs: String = String(format: "%.1f", Double(user[0].userDetails!.weight) * K.Units.kgToLbs)
            
            let savedHeight: String = String(user[0].userDetails!.height)
            let savedHeightInches: String = String(format: "%.1f", Double(user[0].userDetails!.height) * K.Units.cmToInch)
            
            if newValue[0] != user[0].userDetails!.gender! || newValue[2] != String(user[0].userDetails!.age) || newValue[3] != (user[0].userDetails!.units == "metric" ? savedWeight : savedWeightLbs) || newValue[4] != (user[0].userDetails!.units == "metric" ? savedHeight : savedHeightInches) {
                withAnimation(.easeOut(duration: 0.2)) {
                    autofill = false
                }
            }
        }
        .onChange(of: autofill) { oldValue, newValue in
            if newValue {
                enableAutoFill()
            }
        }
        .onChange(of: self.weightPerWeek) { oldValue, newValue in
            calculate()
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
    
    func calculate() {
        withAnimation {
            if validations == Array(repeating: false, count: 3) {
                if CalculatorsCommonController.validate(age: self.age, weight: self.weight, height: self.height, activityLevel: self.activityLevel) {
                    withAnimation(.bouncy) {
                        showResult = true
                        result = CaloriesCalculatorController.calculateCalories(weightPerWeek: self.weightPerWeek, activityLevel: activityLevel, gender: self.gender, age: Double(self.age)!, weight: Double(self.weight)!, height: Double(self.height)!)
                    }
                }
            }
        }
    }
}

#Preview {
    CaloriesCalculatorInputView(showResult: .constant(true), result: .constant(1480), weightPerWeek: .constant(100), gender: .constant(.Male), age: .constant(""), weight: .constant(""), height: .constant(""), activityLevel: .constant(.SelectActivity))
        .padding()
}
