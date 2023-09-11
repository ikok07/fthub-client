//
//  CustomValueInputView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 11.09.23.
//

import SwiftUI

struct CustomValueInputView<Content: View>: View {
    
    @Binding var value: Double
    
    let icon: String
    let name: String
    let pickerWidth: Double
    
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
            
            HStack(spacing: 0) {
                VStack {
                    Image(systemName: "chevron.up")
                        .foregroundStyle(.textGray)
                        .font(.footnote)
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.textGray)
                        .font(.footnote)
                }
                picker()
                .pickerStyle(.wheel)
                .frame(width: pickerWidth, height: 50)
            }
        }
    }
}

#Preview {
    CustomValueInputView(value: .constant(30), icon: "scalemass", name: "Weight", pickerWidth: 90) { 
        Picker("", selection: .constant(25)) {
            ForEach(0..<50, id: \.self) { i in
                Text("\(i) kg")
            }
        }
    }
        .padding()
}
