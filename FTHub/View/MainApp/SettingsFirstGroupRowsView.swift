//
//  SettingsGroupRowsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 6.09.23.
//

import SwiftUI

struct SettingsFirstGroupRowsView: View {
    
    @Binding var appleHealth: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SettingsRowView(icon: "person", image: nil, label: "Profile Data")
            SettingsRowView(icon: "star", image: nil, label: "Subscription")
            SettingsRowView(icon: "key.horizontal", image: nil, label: "Change Password")
            SettingsRowView(icon: "clock.arrow.2.circlepath", image: nil, label: "Workouts Synchronization")
            SettingsRowView(icon: "bell", image: nil, label: "Notifications")
            SettingsRowToggleView(icon: "heart", label: "Apple Health", isToggled: $appleHealth)
        }
    }
}

#Preview {
    SettingsFirstGroupRowsView(appleHealth: .constant(true))
}
