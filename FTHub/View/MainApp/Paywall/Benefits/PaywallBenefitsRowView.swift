//
//  PaywallBenefitsRowView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 18.09.23.
//

import SwiftUI

struct PaywallBenefitsRowView: View {
    
    let icon: String
    let heading: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .foregroundStyle(K.Gradients.mainGradient)
                .font(.title)
            
            VStack(alignment: .leading, spacing: 7) {
                Text(heading)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(description)
            }
        }
    }
}

#Preview {
    PaywallBenefitsRowView(icon: "storefront.fill", heading: "Program marketplace", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt")
}
