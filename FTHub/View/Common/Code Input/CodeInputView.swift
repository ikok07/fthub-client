//
//  PinInputView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct CodeInputView: View {
    
    
    @Binding var enteredPin: [String]
    @State var firstFieldFocused: Bool = true
    
    var body: some View {
            
            HStack(spacing: 20) {
                ForEach(0..<enteredPin.count, id: \.self) { index in
                    if index == 0 {
                        CodeInputTextFieldView(text: $enteredPin[index], index: index, isFirst: true)
                    } else {
                        CodeInputTextFieldView(text: $enteredPin[index], index: index, isFirst: false)
                    }
                } //: ForEach
            } //: HStack

    }
}

#Preview {
    CodeInputView(enteredPin: .constant(Array(repeating: "", count: 6)))
        .padding(.horizontal, 20)
}
