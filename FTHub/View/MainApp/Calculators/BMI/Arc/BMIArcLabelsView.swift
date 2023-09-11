//
//  BMIArcLabels.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 11.09.23.
//

import SwiftUI

struct BMIArcLabelsView: View {
    
    let width: CGFloat
    let borderWidth: CGFloat
    
    var body: some View {
        HStack {
            Text("Underweight")
                .foregroundStyle(.textGray)
                .font(.footnote)
                .offset(x: -borderWidth / 1.5)
            
            Spacer()
            
            Text("Obesity")
                .foregroundStyle(.textGray)
                .font(.footnote)
                .offset(x: borderWidth / 2.75)
        }
        .frame(maxWidth: width + borderWidth)
        .offset(y: 20)
    }
}

#Preview {
    BMIArcLabelsView(width: 300, borderWidth: 20)
}
