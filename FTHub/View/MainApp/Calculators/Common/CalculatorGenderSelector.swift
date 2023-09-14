//
//  CalculatorGenderSelector.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct CalculatorGenderSelector: View {
    
    @Binding var activeGender: Gender
    
    var body: some View {
        HStack {
            Button(action: { activeGender = .Male }, label: {
                HStack {
                    Spacer()
                    Image("Male\(activeGender == .Male ? "" : "-gray")")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    Text("Male")
                        .foregroundStyle(activeGender == .Male ? .white : .textGray)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background {
                    if activeGender == .Male {
                        K.Gradients.mainGradient
                    } else {
                        K.Gradients.clearGradient
                    }
                }
                .background(.ultraThinMaterial)
                .animation(.easeOut, value: activeGender)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            })
            
            Button(action: { activeGender = .Female }, label: {
                HStack {
                    Spacer()
                    Image("Female\(activeGender == .Female ? "" : "-gray")")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    Text("Female")
                        .foregroundStyle(activeGender == .Female ? .white : .textGray)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background {
                    if activeGender == .Female {
                        K.Gradients.mainGradient
                    } else {
                        K.Gradients.clearGradient
                    }
                }
                .background(.ultraThinMaterial)
                .animation(.easeOut, value: activeGender)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            })
        }
    }
}

#Preview {
    CalculatorGenderSelector(activeGender: .constant(.Male))
        .padding()
}
