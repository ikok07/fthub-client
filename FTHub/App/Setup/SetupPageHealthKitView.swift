//
//  SetupPageHealthKitView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI

struct SetupPageHealthKitView: View {
    
    @EnvironmentObject private var healthKitController: HealthKitController
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "Connect your", bottomPart: "health app")
                
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been ")
            }
            .padding(.top)
            
            Button(action: {
                healthKitController.checkAuthStatus()
            }, label: {
                Text("Connect")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding(.vertical)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SetupPageHealthKitView()
        .environmentObject(HealthKitController())
}
