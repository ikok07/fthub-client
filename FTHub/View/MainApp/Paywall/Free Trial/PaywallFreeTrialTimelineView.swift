//
//  PaywallFreeTrialTimelineView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 18.09.23.
//

import SwiftUI

struct PaywallFreeTrialTimelineView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color("timelineBackground"), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.92, green: 0.92, blue: 0.92).opacity(0), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0.44),
                    endPoint: UnitPoint(x: 0.53, y: 1.03)
                )
                
                K.Gradients.mainGradient
                    .frame(height: 225)
                    .clipShape(RoundedRectangle(cornerRadius: 12.5))
                
                VStack(spacing: 73) {
                    Image(systemName: "lock.open.fill")
                        .foregroundStyle(.white)
                        .padding(.top, 5)
                    
                    Image(systemName: "bell.fill")
                        .foregroundStyle(.white)
                        .padding(.top, 5)
                    
                    Image(systemName: "star.fill")
                        .foregroundStyle(.white)
                        .padding(.top, 5)
                }
            }
        }
        .frame(width: 27, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 12.5))
    }
}

#Preview {
    PaywallFreeTrialTimelineView()
}
