//
//  BMIInputsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct BMIInputsView: View {
    
    @Binding var age: String
    @Binding var weight: String
    @Binding var height: String
    
    var body: some View {
        VStack {
            
            VStack(spacing: 15) {
                CustomInputField(unit: "A", placeholder: "Age", text: $age)
                CustomInputField(unit: "KG", placeholder: "Weight", text: $weight)
                CustomInputField(unit: "CM", placeholder: "Height", text: $height)
            }
            .padding()
            
            Button(action: {}, label: {
                Text("Calculate")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
        }
    }
}

#Preview {
    BMIInputsView(age: .constant(""), weight: .constant(""), height: .constant(""))
        .padding()
}
