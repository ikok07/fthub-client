//
//  NumpadButtonView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 19.08.23.
//

import SwiftUI

struct NumpadButtonView: View {
    
    @EnvironmentObject var numpadController: NumpadController
    
    let value: String
    
    var body: some View {
        ZStack {
            Button(action: {
                if Int(value) != nil {
                    numpadController.updateNumber(with: value)
                } else {
                    numpadController.deleteLastDigit()
                }
            }, label: {
                Spacer()
                if Int(value) != nil || value == " " {
                    Text(value)
                        .foregroundStyle(Color(UIColor.label))
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 14, leading: 10, bottom: 14, trailing: 10))
                } else {
                    Image(systemName: value)
                        .foregroundStyle(Color(UIColor.label))
                        .font(.title2)
                        .padding(EdgeInsets(top: 14, leading: 10, bottom: 14, trailing: 10))
                }
                Spacer()
            })
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NumpadButtonView(value: "2")
        .environmentObject(NumpadController())
}
