//
//  SettingsNotificationsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 9.09.23.
//

import SwiftUI

struct SettingsNotificationsView: View {
    
    @State private var newsletter: Bool = false
    @State private var deals: Bool = false
    @State private var workoutReminders: Bool = false
    @State private var dailyChallenge: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                SettingsGroupView(name: "Notification Types") {
                    SettingsRowToggleView(icon: "newspaper", label: "Newsletter", isToggled: $newsletter)
                    SettingsRowToggleView(icon: "sparkles", label: "Special Deals", isToggled: $deals)
                    SettingsRowToggleView(icon: "dumbbell", label: "Workouts", isToggled: $workoutReminders)
                    SettingsRowToggleView(icon: "calendar", label: "Daily Challenges", isToggled: $dailyChallenge)
                }
                Spacer()
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

#Preview {
    SettingsNotificationsView()
}
