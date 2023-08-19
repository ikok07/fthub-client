//
//  PinInputView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct CodeAuthView: View {
    
    @EnvironmentObject var numpadController: NumpadController
    @Binding var fullFields: Bool
    
    var body: some View {
            HStack(spacing: 20) {
                ForEach(0..<numpadController.enteredNumber.count, id: \.self) { index in
                    CustomCodeNumberField(isActive: numpadController.activeField == index ? true : false, number: Int(numpadController.enteredNumber[index]))
                        .onTapGesture {
                            numpadController.setActiveField(on: index)
                        }
                } //: ForEach
            } //: HStack
    }
}

#Preview {
    CodeAuthView(fullFields: .constant(false))
        .padding(.horizontal, 20)
        .environmentObject(NumpadController())
}
