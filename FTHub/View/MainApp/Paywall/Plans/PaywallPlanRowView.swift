//
//  PaywallPlanRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 18.09.23.
//

import SwiftUI

enum SubscriptionPlan: String, CaseIterable, Codable {
    case Monthly, Yearly
}

struct PaywallPlanRowView: View {
    
    @Binding var selectedPlan: SubscriptionPlan
    
    var active: Bool {
        if selectedPlan == planType {
            return true
        } else {
            return false
        }
    }
    let planType: SubscriptionPlan
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 15) {
                Image(systemName: active ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(active ? .white : .textGray)
                    .font(.title)
                
                VStack(alignment: .leading) {
                    Text(planType == .Monthly ? "Monthly" : "Yearly")
                        .foregroundStyle(active ? .white : .textGray)
                        .font(.body)
                        .fontWeight(active ? .semibold : .bold)
                    
                    Text(planType == .Monthly ? "2,39$" : "24,65$")
                        .foregroundStyle(active ? .white : .text)
                        .font(.title)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(active ? K.Gradients.mainGradient : K.Gradients.whiteGradientForDark)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .textfieldBg.opacity(0.3), radius: 5, x: 0, y: 2)
            
            if planType == .Yearly {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Save 15%")
                            .foregroundStyle(active ? .white : .accent)
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 3, trailing: 10))
                            .background( active ?
                                LinearGradient(
                                    stops: [
                                    Gradient.Stop(color: Color(red: 0.27, green: 0.74, blue: 0.26), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.26, green: 0.74, blue: 0.64), location: 1.00),
                                    ],
                                    startPoint: UnitPoint(x: -1, y: -1.42),
                                    endPoint: UnitPoint(x: 0.5, y: 0.25)
                                ) : K.Gradients.whiteGradientForDark
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .textfieldBg.opacity(active ? 0 : 0.15), radius: 4, x: 0, y: 8)
                    }
                }
                .offset(y: 14)
            }
        }
        .onTapGesture {
            selectedPlan = planType
        }
    }
}

#Preview {
    PaywallPlanRowView(selectedPlan: .constant(.Monthly), planType: .Yearly)
        .frame(height: 65)
        .padding()
}
