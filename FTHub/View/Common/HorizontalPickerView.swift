//
//  HorizontalPickerView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import SwiftUI

struct HorizontalPickerView: View {
    
    @Binding var offset: CGFloat
    
    let minValue: Int
    let maxValue: Int
    var pickerCount: Int {
        let doubleValue: Double = ceil((Double(maxValue) - Double(minValue) - 1.0) / 5.0)
        return Int(doubleValue)
    }
    
    var body: some View {
        HorizontalPickerUIKitView(pickerCount: pickerCount, offset: $offset) {
            HStack(spacing: 0) {
                
                ForEach(1...pickerCount, id: \.self) { index in
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 1, height: 30)
                        .frame(width: 20)
                    
                    ForEach(1...4, id: \.self) { subIndex in
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 1, height: 15)
                            .frame(width: 20)
                    }
                }
                
                Rectangle()
                    .fill(.gray)
                    .frame(width: 1, height: 30)
                    .frame(width: 20)
                
            }
            .offset(x: (UIScreen.main.bounds.width - 30) / 2)
            .padding(.trailing, UIScreen.main.bounds.width - 30)
        }
        .frame(height: 50)
        .overlay {
            
            Rectangle()
                .fill(.gray)
                .frame(width: 1, height: 50)
                .offset(x: 1, y: -30)
        }
    }
}

#Preview {
    HorizontalPickerView(offset: .constant(0), minValue: 15, maxValue: 75)
}
