//
//  CustomCodeNumberField.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 19.08.23.
//

import SwiftUI

struct CustomCodeNumberField: View {
    
    let isActive: Bool
    let number: Int?
    
    var body: some View {
        VStack {
            if let safeNumber = number {
                Text("\(safeNumber)")
                    .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
                    .font(.title2)
            } else {
                Text(" ")
                    .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
                    .font(.title2)
            }
            Divider()
                .frame(height: 3)
                .overlay(isActive ? K.Gradients.mainGradient : K.Gradients.grayGradient)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(width: 40)
        .offset(y: isActive ? -10 : 0)
        .animation(.easeOut, value: isActive)
    }
}

#Preview {
    CustomCodeNumberField(isActive: false, number: 2)
}
