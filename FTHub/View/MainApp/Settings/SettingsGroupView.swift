//
//  SettingsGroupView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI

struct SettingsGroupView<Content: View>: View {
    
    let name: String
    @ViewBuilder let rows: Content
    
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 6, height: 30)
                    .foregroundStyle(K.Gradients.mainGradient.opacity(0.75))
                
                Text(name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            rows
            
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
//        .overlay {
//            RoundedRectangle(cornerRadius: 12)
//                .strokeBorder(lineWidth: 1)
//                .foregroundStyle(.customGray)
//        }
    }
}

#Preview {
    SettingsGroupView(name: "Account Settings") {
        VStack(alignment: .leading, spacing: 0) {
            SettingsRowView(icon: nil, image: "instagram", label: "Profile Data")
            SettingsRowView(icon: nil, image: "facebook", label: "Subscription")
            SettingsRowView(icon: "person.2.badge.gearshape", image: nil, label: "Support & Feedback")
            SettingsRowView(icon: "lock", image: nil, label: "Privacy Policy")
        }
    }
        .padding()
}
