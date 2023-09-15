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
    
    @Query private var user: [User]
    
    @State var autofill: Bool = false
    
    @Binding var showResult: Bool
    @Binding var result: Double
    @Binding var selectedOption: CaloriesCalculatorResultOption
    
    @Binding var gender: Gender
    @Binding var age: String
    @Binding var weight: String
    @Binding var height: String
    @Binding var activityLevel: ActivityLevel
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                
                SwiftUICustomizablePicker(CaloriesCalculatorResultOption.allCases, selection: $selectedOption) { item in
                    Text("\(item.rawValue)".camelCaseToWords())
                        .foregroundStyle(selectedOption == item ? .white : .text.opacity(0.7))
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .fixedSize()
                        .lineSpacing(-20)
                        .multilineTextAlignment(.center)
                        .animation(.easeOut, value: selectedOption)
                }
                .frame(width: .infinity, height: 32)
                .backgroundColor(.textfieldAppearance)
                .indicatorBackgroundGradient(K.Gradients.mainGradient)
                .indicatorPadding(EdgeInsets(top: 0.5, leading: 0.5, bottom: 0.5, trailing: 0.5))
                .innerPadding(EdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3))
                .shadow(color: .textfieldBg.opacity(0.3), radius: 3, x: 2, y: 2)
                .sensoryFeedback(.impact, trigger: selectedOption)
                
                CustomInputField(isActive: _isActive, icon: "calendar", unit: "years", placeholder: "Age", numpad: true, text: $age)
                
                CustomInputField(isActive: _isActive, icon: "scalemass.fill", unit: user.first?.details?.units == .metric ? "kg" : "lb", placeholder: "Weight", numpad: true, text: $weight)
                
                CustomInputField(isActive: _isActive, icon: "arrow.up.and.down", unit: user.first?.details?.units == .metric ? "cm" : "in", placeholder: "Height", numpad: true, text: $height)
                
                CustomPickerRowView(icon: "figure.run", name: "Activity") {
                    Picker("", selection: $activityLevel) {
                        ForEach(ActivityLevel.allCases, id: \.self) { level in
                            Text("\(level.rawValue)".camelCaseToWords())
                        }
                    }
                    .tint(activityLevel == .SelectActivity ? .textGray : .text)
                }
                
                AutofillButtonView(autofill: $autofill)
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
            print(newValue)
            print(String(format: "%.1f", Double((user.first?.details?.height!)!) * K.Units.cmToInch))
            if let user = user.first, user.details != nil {
                
                let savedWeight: String = String(user.details!.weight!)
                let savedWeightLbs: String = String(format: "%.1f", Double(user.details!.weight!) * K.Units.kgToLbs)
                
                let savedHeight: String = String(user.details!.height!)
                let savedHeightInches: String = String(format: "%.1f", Double(user.details!.height!) * K.Units.cmToInch)
                
                if newValue[0] != user.details!.gender!.rawValue || newValue[2] != String(user.details!.age!) || newValue[3] != (user.details!.units == .metric ? savedWeight : savedWeightLbs) || newValue[4] != (user.details!.units == .metric ? savedHeight : savedHeightInches) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        autofill = false
                    }
                }
            }
        }
        .onChange(of: autofill) { oldValue, newValue in
            if newValue {
                enableAutoFill()
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
    
    func calculate() {
        if CalculatorsCommonController.validate(age: self.age, weight: self.weight, height: self.height, activityLevel: self.activityLevel) {
            withAnimation(.bouncy) {
                showResult = true
                result = CaloriesCalculatorController.calculateCalories(selectedOption: self.selectedOption, activityLevel: activityLevel, gender: self.gender, age: Double(self.age)!, weight: Double(self.weight)!, height: Double(self.height)!)
            }
        }
    }
}

#Preview {
    CaloriesCalculatorInputView(showResult: .constant(true), result: .constant(1480), selectedOption: .constant(.MaintainWeight), gender: .constant(.Male), age: .constant(""), weight: .constant(""), height: .constant(""), activityLevel: .constant(.SelectActivity))
        .padding()
}
