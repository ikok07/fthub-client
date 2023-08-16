//
//  PinInputView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct CodeAuthView: View {
    
    @FocusState var fieldFocus: Int?
    
    @Binding var code: Int
    @Binding var enteredNumbers: [String]
    @Binding var fullFields: Bool
    @State private var oldValue: String = ""
    
    var body: some View {
            HStack(spacing: 20) {
                ForEach(0..<enteredNumbers.count, id: \.self) { index in
                    TextField("", text: $enteredNumbers[index], onEditingChanged: { editing in
                        if editing {
                           oldValue = enteredNumbers[index]
                        }
                    })
                        .keyboardType(.numberPad)
                        .foregroundStyle(.accent)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay {
                            if enteredNumbers[index].count > 0 {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(K.mainGradient.opacity(0.15))
                            }
                        }
                        .focused($fieldFocus, equals: index)
                        .onChange(of: enteredNumbers[index]) { oldValue, newValue in
                            if enteredNumbers[index].count > 1 {
                                let currentValue = Array(enteredNumbers[index])
                                
                                if currentValue[0] == Character(oldValue) {
                                    enteredNumbers[index] = String(enteredNumbers[index].suffix(1))
                                } else {
                                    enteredNumbers[index] = String(enteredNumbers[index].prefix(1))
                                }
                            }
                            if !newValue.isEmpty {
                                fieldFocus = ( fieldFocus ?? 0) + 1
                            } else {
                                fieldFocus = ( fieldFocus ?? 0) - 1
                            }
                            
                            withAnimation(.easeOut(duration: 0.2)) {
                                if enteredNumbers.joined().count == 6 {
                                    fullFields = true
                                } else {
                                    fullFields = false
                                }
                            }
                            
                            code = Int(enteredNumbers.joined()) ?? 0
                        } //: onChange
                        .onAppear {
                            fieldFocus = 0
                        }
                } //: ForEach
            } //: HStack

    }
}

#Preview {
    CodeAuthView(code: .constant(0), enteredNumbers: .constant(Array(repeating: "", count: 6)), fullFields: .constant(false))
        .padding(.horizontal, 20)
}
