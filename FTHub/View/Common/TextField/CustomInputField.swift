//
//  CustomInputField.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct CustomInputField: View {
    
    let unit: String
    let placeholder: String
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            ZStack {
                Text(unit)
                    .foregroundStyle(.text.opacity(0.12))
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(width: 45, height: 45)
            
            TextField(placeholder, text: $text)
        }
        .frame(height: 45)
        .background(.textfieldAppearance)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .textfieldBg.opacity(0.3), radius: 3, x: 2, y: 2)
        
    }
}

#Preview {
    CustomInputField(unit: "KG", placeholder: "Weight", text: .constant(""))
        .padding()
}
