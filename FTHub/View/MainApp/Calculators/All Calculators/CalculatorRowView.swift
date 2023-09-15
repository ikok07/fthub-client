//
//  CalculatorRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI

struct CalculatorRowView: View {
    
    let icon: String
    let name: String
    
    var body: some View {
    
            VStack(spacing: 0) {
                
                Divider()
                    .padding(.vertical, 10)
                
                HStack {
                    HStack {
                        Image(systemName: icon)
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .background(K.Gradients.mainGradient)
                            .clipShape(Circle())
                        
                        Text(name)
                            .foregroundStyle(.text)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.text)
                }
            }
            .contentShape(Rectangle())
    }
}

#Preview {
    CalculatorRowView(icon: "flame.fill", name: "BMI")
        .padding()
}
