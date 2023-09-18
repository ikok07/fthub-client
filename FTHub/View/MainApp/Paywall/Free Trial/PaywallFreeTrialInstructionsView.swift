//
//  PaywallFreeTrialInstructionsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 18.09.23.
//

import SwiftUI

struct PaywallFreeTrialInstructionsView: View {
    var body: some View {
        VStack(spacing: 35) {
            Text("An overview of\n our free trial")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            HStack(alignment: .top, spacing: 20) {
                PaywallFreeTrialTimelineView()
                
                VStack(alignment: .leading, spacing: 25) {
                    PaywallFreeTrialRowView(title: "Today", description: "Get instant access and feel the full potential of FTHub")
                    
                    PaywallFreeTrialRowView(title: "Day 5", description: "An email and notification informing about your ending trial will be sent to you")
                    PaywallFreeTrialRowView(title: "Day 7", description: "You’ll be charged on January 12, cancel anytime before.")
                }
            }
        }
    }
}

#Preview {
    PaywallFreeTrialInstructionsView()
        .padding()
}
