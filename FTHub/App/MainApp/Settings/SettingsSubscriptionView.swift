//
//  SettingsSubscriptionView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 9.09.23.
//

import SwiftUI

struct SettingsSubscriptionView: View {
    var body: some View {
        NavigationStack {
            VStack {
                SettingsGroupView(name: "Subscription") {
                    SettingsInputRowView(name: "Plan") {
                        Text("Premium")
                            .font(.subheadline)
                            .fontWeight(.regular)
                    }
                    SettingsInputRowView(name: "Renewal Date") {
                        Text("23.01.2023")
                            .font(.subheadline)
                            .fontWeight(.regular)
                    }
                    SettingsInputRowView(name: "Price") {
                        Text("2.79€ / month")
                            .font(.subheadline)
                            .fontWeight(.regular)
                    }
                    Button(action: cancelSubscription, label: {
                        Text("Cancel Subscription")
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    })
                    .buttonStyle(CTAButtonStyle(gradient: K.Gradients.redGradient, opacity: 0.85))
                    .padding(.top, 5)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Subscription")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func cancelSubscription() {
        
    }
}

#Preview {
    SettingsSubscriptionView()
}
