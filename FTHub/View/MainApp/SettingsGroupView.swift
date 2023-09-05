//
//  SettingsGroupView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 5.09.23.
//

import SwiftUI

struct SettingsGroupView: View {
    
    @State private var appleHealth: Bool = false
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 6, height: 30)
                    .foregroundStyle(K.Gradients.mainGradient.opacity(0.75))
                
                Text("Account Settings")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 0) {
                SettingsRowView(icon: "person", label: "Profile Data")
                SettingsRowView(icon: "star", label: "Subscription")
                SettingsRowView(icon: "key.horizontal", label: "Change Password")
                SettingsRowView(icon: "clock.arrow.2.circlepath", label: "Workouts Synchronization")
                SettingsRowView(icon: "bell", label: "Notifications")
                SettingsRowToggleView(icon: "heart", label: "Apple Health", isToggled: $appleHealth)
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(lineWidth: 1)
                .foregroundStyle(.customGray)
        }
    }
}

#Preview {
    SettingsGroupView()
        .padding()
}
