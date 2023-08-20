//
//  PinInputView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 15.08.23.
//

import SwiftUI

struct CodeAuthView: View {
    
    @EnvironmentObject var numpadController: NumpadController
    
    var body: some View {
            HStack(spacing: 20) {
                ForEach(0..<numpadController.enteredNumbers.count, id: \.self) { index in
                    CustomCodeNumberField(isActive: numpadController.activeField == index ? true : false, number: Int(numpadController.enteredNumbers[index]))
                        .onTapGesture {
                            numpadController.setActiveField(on: index)
                        }
                } //: ForEach
            } //: HStack
    }
}

#Preview {
    CodeAuthView()
        .padding(.horizontal, 20)
        .environmentObject(NumpadController())
}
