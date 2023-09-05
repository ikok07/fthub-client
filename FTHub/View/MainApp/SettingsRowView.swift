//
//  SettingsRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI

struct SettingsRowView: View {
    
    let icon: String
    let label: String
    
    @State private var isPressed: Bool = false
    
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
                    
                    Image(systemName: "chevron.right")
                }
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 10))
                .frame(height: 50)
                .background(isPressed ? Color(UIColor.label).opacity(0.3) : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundStyle(.customGray)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    isPressed.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        isPressed.toggle()
                    }
                }
            }
    }
}

#Preview {
    SettingsRowView(icon: "person", label: "Profile data")
        .padding()
}
