//
//  PaywallMainView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 18.09.23.
//

import SwiftUI

struct PaywallMainView: View {
    
    @Binding var isPresented: Bool
    @State private var selectedPlan: SubscriptionPlan = .Yearly
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Image("paywall0")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
                
                VStack(spacing: 30) {
                    TwoLineHeadingView(upperPart: "Upgrade your", bottomPart: "account plan")
                    
                    PaywallBenefitsView()
                    
                    PaywallPlansView(selectedPlan: $selectedPlan)
                    
                    PaywallFreeTrialInstructionsView()
                }
                .padding(.bottom)
            }
            .padding()
            .scrollIndicators(.hidden)
            .toolbar {
                Button(action: {isPresented = false }) {
                    Image(systemName: "xmark")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    PaywallMainView(isPresented: .constant(true))
}
