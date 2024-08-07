//
//  SettingsInputRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 6.09.23.
//

import SwiftUI

struct SettingsInputRowView<Content: View>: View {
    
    let name: String
    @ViewBuilder let input: Content
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(name)
                    .fontWeight(.bold)
                
                Spacer()
                
                input
            }
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10))
            .frame(height: 40)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.customGray.opacity(0.6))
        }
    }
}

#Preview {
    SettingsInputRowView(name: "Height") {
        TextField("", text: .constant("120"))
            .frame(width: 75)
            .multilineTextAlignment(.trailing)
        
        Text("cm")
    }
        .padding()
}
