//
//  PinInputTextFieldView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct CodeInputTextFieldView: View {
    
    @FocusState private var isFocused: Bool
    
    @Binding var text: String
    let index: Int
    let isFirst: Bool
    
    var body: some View {
        if isFirst {
            TextField("", text: $text)
                .keyboardType(.numberPad)
                .foregroundStyle(.accent)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.customGray, lineWidth: 3)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .focused($isFocused)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isFocused = true
                    }
                }
        } else {
            TextField("", text: $text)
                .keyboardType(.numberPad)
                .foregroundStyle(.accent)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.customGray, lineWidth: 3)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    CodeInputTextFieldView(text: .constant(""), index: 0, isFirst: true)
}
