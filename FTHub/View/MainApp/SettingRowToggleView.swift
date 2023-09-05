//
//  SettingsRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI

struct SettingsRowToggleView: View {
    
    let icon: String
    let label: String
    
    @Binding var isToggled: Bool
    
    var body: some View {
        VStack(spacing: 0) {
                HStack {
                    HStack(spacing: 10) {
                        Image(systemName: icon)
                            .font(.system(size: 25))
                            .frame(width: 30)
                        
                        Text(label)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $isToggled)
                }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10))
                .frame(height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundStyle(.customGray)
            }
            .contentShape(Rectangle())
    }
}

#Preview {
    SettingsRowToggleView(icon: "person", label: "Profile data", isToggled: .constant(true))
        .padding()
}
