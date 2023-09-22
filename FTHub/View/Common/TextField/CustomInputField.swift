//
//  CustomInputField.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

enum CustomInputType: String, CaseIterable, Codable {
    case undefined, age, weight, height, waist, hip, neck
}

struct CustomInputField: View {
    
    @FocusState var isActive: Bool
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    var type: CustomInputType = .undefined
    let icon: String
    let unit: String
    let placeholder: String
    var numpad: Bool = false
    
    @Binding var text: String
    @Binding var validationResult: Bool?
    
    @State private var errorDetails: (Bool, String?) = (false, nil)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    K.Gradients.mainGradient
                    
                    Image(systemName: icon)
                        .foregroundStyle(.white.opacity(0.8))
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .frame(width: 45, height: 45)
                
                TextField(placeholder, text: $text)
                    .keyboardType(numpad ? .decimalPad : .default)
                    .focused($isActive)
                
                Text(unit.uppercased())
                    .foregroundStyle(.text.opacity(0.2))
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.trailing, 10)
            }
            .frame(height: 45)
            .background(.textfieldAppearance)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .textfieldBg.opacity(0.3), radius: 3, x: 2, y: 2)
            
            if errorDetails.0 {
                Text(errorDetails.1 ?? "Insert valid value")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.textfieldError)
                    .padding(.horizontal)
            }
        }
        .padding(.bottom, errorDetails.0 ? 5 : 20)
        .onChange(of: text) { oldValue, newValue in
                text = text.replacingOccurrences(of: ",", with: ".")
            withAnimation(.easeOut) {
                errorDetails = CustomInputValidationController.validate(type: type, value: Double(text) ?? 0, units: user[0].userDetails?.units ?? "metric")
                validationResult = errorDetails.0
            }
        }
        
    }
    
}

#Preview {
    CustomInputField(icon: "scalemass.fill", unit: "KG", placeholder: "Weight", text: .constant(""), validationResult: .constant(nil))
        .padding()
}
