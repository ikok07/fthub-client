//
//  SettingsSecondGroupRowsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 6.09.23.
//

import SwiftUI

struct SettingsSecondGroupRowsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SettingsRowView(icon: nil, image: "instagram", label: "Profile Data")
            SettingsRowView(icon: nil, image: "facebook", label: "Subscription")
            SettingsRowView(icon: "person.2.badge.gearshape", image: nil, label: "Support & Feedback")
            SettingsRowView(icon: "lock", image: nil, label: "Privacy Policy")
        }
    }
}

#Preview {
    SettingsSecondGroupRowsView()
        .padding()
}
