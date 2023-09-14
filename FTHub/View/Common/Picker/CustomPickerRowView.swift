//
//  CustomPickerRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 12.09.23.
//

import SwiftUI

struct CustomPickerRowView<Content:View>: View {
    
    let icon: String
    let name: String
    
    let picker: () -> Content
    
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
            
            picker()
                .offset(x: -10)
            
            Spacer()
        }
        .frame(height: 45)
        .background(.textfieldAppearance)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .textfieldBg.opacity(0.3), radius: 3, x: 2, y: 2)
        
    }
}

#Preview {
    CustomPickerRowView(icon: "figure.run", name: "Activity") {
        Picker("", selection: .constant(ActivityLevel.SelectActivity)) {
            ForEach(ActivityLevel.allCases, id: \.self) { level in
                Text("\(level.rawValue)".camelCaseToWords())
            }
        }
        .tint(.text)
    }
    .padding()
}
