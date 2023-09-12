//
//  CaloriesCalculatorInputView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import SwiftUI
import SwiftData

enum ActivityLevel: String, Codable, CaseIterable {
    case Light, Active, VeryActive, UltraActive
}

struct CaloriesCalculatorInputView: View {
    
    @Query private var user: [User]
    
    @State var autofill: Bool = false
    
    @Binding var result: Double
    @Binding var selectedOption: CaloriesCalculatorResultOption
    
    @Binding var gender: Gender
    @Binding var age: Double
    @Binding var weight: Double
    @Binding var height: Double
    @Binding var activityLevel: ActivityLevel
    
    var body: some View {
        VStack {
            VStack(spacing: 5) {
                CustomPickerRowView(icon: "figure.run", name: "Activity") {
                    Picker("", selection: $activityLevel) {
                        ForEach(ActivityLevel.allCases, id: \.self) { level in
                            Text("\(level.rawValue)".camelCaseToWords())
                        }
                    }
                }
                
                CustomValueInputView(value: $age, icon: "calendar", name: "Age", pickerWidth: 60) {
                    Picker("", selection: $age) {
                        ForEach(K.UserDetails.minAge...K.UserDetails.maxAge, id: \.self) { i in
                            Text("\(i)")
                                .tag(Double(i))
                        }
                    }
                }
                
                CustomValueInputView(value: $weight, icon: "scalemass", name: "Weight", pickerWidth: user.first?.details?.units == .metric ? 95 : 120) {
                    Picker("", selection: $weight) {
                        ForEach(user.first?.details?.units == .metric ? K.Units.getWeightRange(units: .metric) : K.Units.getWeightRange(units: .imperial), id: \.self) { i in
                            Text(user.first?.details?.units == .metric ? "\(Int(i)) kg" : "\(String(format: "%.1f", i)) lbs")
                                .tag(i)
                        }
                    }
                }
                
                CustomValueInputView(value: $height, icon: "arrow.up.and.down", name: "Height", pickerWidth: user.first?.details?.units == .metric ? 90 : 125) {
                    Picker("", selection: $height) {
                        ForEach(user.first?.details?.units == .metric ? K.Units.getHeightRange(units: .metric) : K.Units.getHeightRange(units: .imperial), id: \.self) { i in
                            Text(user.first?.details?.units == .metric ? "\(Int(i)) cm" : "\(String(format: "%.1f", i)) inch.")
                                .tag(i)
                        }
                    }
                }
            }
            
            VStack(spacing: 10) {
                Button(action: calculate) {
                    Text("Calculate")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
                .padding(.top)
                
                AutofillButtonView(autofill: $autofill, action: toggleAutoFill)
            }
            
        }
        .padding()
        .onChange(of: [gender.rawValue, activityLevel.rawValue, String(age), String(weight), String(height)]) { oldValue, newValue in
            print(newValue)
            if let user = user.first, user.details != nil {
                if newValue[0] != user.details!.gender!.rawValue || newValue[2] != String(user.details!.age!) || newValue[3] != String(user.details!.weight!) || newValue[4] != String(user.details!.height!) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        autofill = false
                    }
                }
            }
                
        }
    }
    
    func toggleAutoFill() {
        if let user = user.first {
            withAnimation(.easeOut(duration: 0.2)) {
                autofill = true
                age = Double((user.details?.age)!)
                weight = Double((user.details?.weight)!)
                height = Double((user.details?.height)!)
            }
        }
    }
    
    func calculate() {
        withAnimation(.bouncy) {
            result = CaloriesCalculatorController.calculateCalories(selectedOption: self.selectedOption, activityLevel: activityLevel, gender: self.gender, age: self.age, weight: self.weight, height: self.height)
        }
    }
}

#Preview {
    CaloriesCalculatorInputView(result: .constant(1480), selectedOption: .constant(.MaintainWeight), gender: .constant(.Male), age: .constant(16), weight: .constant(62), height: .constant(181), activityLevel: .constant(.VeryActive))
}
