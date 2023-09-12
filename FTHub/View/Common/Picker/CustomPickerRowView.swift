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
            Group {
                Image(systemName: icon)
                    .font(.title2)
                    .frame(width: 30)
                Text(name)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            picker()
            .tint(.text)
        }
    }
}

#Preview {
    CustomPickerRowView(icon: "figure.run", name: "Activity") {
        Picker("", selection: .constant(ActivityLevel.Light)) {
            ForEach(ActivityLevel.allCases, id: \.self) { level in
                Text("\(level.rawValue)".camelCaseToWords())
            }
        }
    }
    .padding()
}
