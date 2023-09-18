//
//  PaywallBenefitsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 18.09.23.
//

import SwiftUI

struct PaywallBenefitsView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Why should you upgrade your plan?")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 20) {
                PaywallBenefitsRowView(icon: "storefront.fill", heading: "Program marketplace", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt")
                
                PaywallBenefitsRowView(icon: "brain.head.profile.fill", heading: "Machine learning", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt")
                
                PaywallBenefitsRowView(icon: "chart.bar.xaxis", heading: "Detailed statistics", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt")
            }
        }
    }
}

#Preview {
    PaywallBenefitsView()
}
