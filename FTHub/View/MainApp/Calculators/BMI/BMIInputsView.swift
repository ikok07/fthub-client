//
//  BMIInputsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI
import SwiftData

struct BMIInputsView: View {
    
    @FocusState var isActive: Bool
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    @State private var autofill: Bool = false
    
    @Binding var gender: Gender
    @Binding var weight: String
    @Binding var height: String
    @Binding var result: Double
    @Binding var showResult: Bool
    
    
    
    var body: some View {
        VStack {
            
            VStack(spacing: 20) {
                CustomInputField(isActive: _isActive, icon: "scalemass.fill", unit: user[0].userDetails!.units == "metric" ? "kg" : "lbs", placeholder: "Weight", numpad: true, text: $weight)
                CustomInputField(isActive: _isActive, icon: "arrow.up.and.down", unit: user[0].userDetails!.units == "metric" ? "cm" : "in", placeholder: "Height", numpad: true, text: $height)
                
                AutofillButtonView(autofill: $autofill)
            }
            .padding()
            
            Button(action: calculate, label: {
                Text("Calculate")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding(.horizontal)
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
        .onChange(of: [gender.rawValue, weight, height]) { oldValue, newValue in
            let savedWeight: String = String(user[0].userDetails!.weight)
            let savedWeightLbs: String = String(format: "%.1f", Double(user[0].userDetails!.weight) * K.Units.kgToLbs)
            
            let savedHeight: String = String(user[0].userDetails!.height)
            let savedHeightInches: String = String(format: "%.1f", Double(user[0].userDetails!.height) * K.Units.cmToInch)
            
            if newValue[0] != user[0].userDetails!.gender || newValue[1] != (user[0].userDetails!.units == "metric" ? savedWeight : savedWeightLbs) || newValue[2] != (user[0].userDetails!.units == "metric" ? savedHeight : savedHeightInches) {
                withAnimation(.easeOut(duration: 0.2)) {
                    autofill = false
                }
            }
        }
        .onChange(of: autofill) { oldValue, newValue in
            if newValue {
                enableAutofill()
            }
        }
    }
    
    func enableAutofill() {
        withAnimation {
            autofill = true
        }
        gender = Gender(rawValue: user[0].userDetails!.gender!)!
        if user[0].userDetails!.units == "imperial" {
            weight = String(format: "%.1f", Double((user[0].userDetails!.weight)) * K.Units.kgToLbs)
            height = String(format: "%.1f", Double((user[0].userDetails!.height)) * K.Units.cmToInch)
        } else {
            weight = String((user[0].userDetails!.weight))
            height = String((user[0].userDetails!.height))
        }
    }
    
    func calculate() {
        if CalculatorsCommonController.validate(weight: self.weight, height: self.height) {
            withAnimation {
                showResult = true
                result = BMIController.calculateBMI(units: Unit(rawValue: user[0].userDetails!.units!)!, weight: Double(self.weight)! , height: Double(self.height)!)
            }
        }
    }
}

#Preview {
    BMIInputsView(gender: .constant(.Male), weight: .constant(""), height: .constant(""), result: .constant(25), showResult: .constant(false))
        .padding()
}
