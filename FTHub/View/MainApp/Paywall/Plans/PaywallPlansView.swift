//
//  PaywallPlansView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 18.09.23.
//

import SwiftUI

struct PaywallPlansView: View {
    
    @Binding var selectedPlan: SubscriptionPlan
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Choose your preferred subscription plan")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 20) {
                PaywallPlanRowView(selectedPlan: $selectedPlan, planType: .Monthly)
                    .frame(height: 65)
                
                PaywallPlanRowView(selectedPlan: $selectedPlan, planType: .Yearly)
                    .frame(height: 65)
            }
        }
    }
}

#Preview {
    PaywallPlansView(selectedPlan: .constant(.Yearly))
        .padding()
}
