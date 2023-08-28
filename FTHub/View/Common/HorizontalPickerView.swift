//
//  HorizontalPickerView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import Foundation
import SwiftUI

struct HorizontalPickerView: View {
    
    @State private var horizontalOffset: CGFloat = 0.0
    @Binding var value: Int
    
    let linesPerValueChange: CGFloat = 10
    let maxValue: CGFloat = 100
    
    var body: some View {
        
        OffsettableScrollView(axes: .horizontal, showsIndicator: false) { point in
            horizontalOffset = point.x
        } content: {
            LazyHStack {
                ForEach(0..<300, id: \.self) { i in
                    if i % 10 == 0 {
                        RoundedRectangle(cornerRadius: 0)
                        .frame(width: 1, height: 35)
                        .foregroundStyle(.textGray)
                    } else {
                        RoundedRectangle(cornerRadius: 0)
                        .frame(width: 1, height: 15)
                        .foregroundStyle(.textGray)
                    }
                }
            }
        }
        .onChange(of: horizontalOffset) { oldValue, newValue in
            let mappedValue = max(0, min(Int(round(newValue / linesPerValueChange)), Int(maxValue)))
          value = mappedValue
        }
        Text("\(value)")
    }
}

#Preview {
    HorizontalPickerView(value: .constant(0))
}
