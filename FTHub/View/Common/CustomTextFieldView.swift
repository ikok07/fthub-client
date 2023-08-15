//
//  CustomTextFieldView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    let icon: String
    let placeholder: String
    @Binding var text: String

    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .font(.title2)
                .padding(.trailing, 5)
            
            TextField(placeholder, text: $text)
                .fontWeight(.bold)
        }
        .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 10))
        .padding(.horizontal)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.customGray, lineWidth: 2)
        }
    }
}

#Preview {
    CustomTextFieldView(icon: "envelope", placeholder: "Placeholder", text: .constant(""))
        .padding()
}
