//
//  PaywallFreeTrialRow.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 18.09.23.
//

import SwiftUI

struct PaywallFreeTrialRowView: View {
    
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(description)
        }
    }
}

#Preview {
    PaywallFreeTrialRowView(title: "Today", description: "Get instant access and feel the full potential of FTHub")
}
