//
//  CustomInputField.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct CustomInputField: View {
    
    @FocusState var isActive: Bool
    
    let icon: String
    let unit: String
    let placeholder: String
    var numpad: Bool = false
    
    @Binding var text: String
    
    var body: some View {
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
        .onChange(of: text) { oldValue, newValue in
                text = text.replacingOccurrences(of: ",", with: ".")
        }
        
    }
}

#Preview {
    CustomInputField(icon: "scalemass.fill", unit: "KG", placeholder: "Weight", text: .constant(""))
        .padding()
}
