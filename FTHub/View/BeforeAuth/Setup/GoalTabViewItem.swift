//
//  GoalTabViewItem.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI

struct GoalTabViewItem: View {
    
    let active: Bool
    let header: String
    let description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(header)
                .foregroundStyle(active ? .white : .text)
                .font(.title)
                .fontWeight(.bold)
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundStyle(active ? .white : .textGray)
                .fontWeight(.semibold)
            
            Image(systemName: active ? "checkmark.circle" : "circle")
                .symbolEffect(.bounce, value: active)
                .foregroundStyle(active ? .white : .textGray)
                .font(.title)
                .fontWeight(.semibold)
            
        }
        .frame(height: 175)
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
        .background {
            if active {
                K.Gradients.mainGradient
            }
        }
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    GoalTabViewItem(active: false, header: "Lose Weight", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been ")
}
