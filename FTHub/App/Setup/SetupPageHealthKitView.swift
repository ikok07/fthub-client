//
//  SetupPageHealthKitView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI

struct SetupPageHealthKitView: View {
    
    @EnvironmentObject private var healthKitController: HealthKitController
    @EnvironmentObject private var setupController: SetupController
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "Connect your", bottomPart: "health app")
                
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been ")
            }
            .padding(.top)
            
            VStack {
                Button(action: {
                    healthKitController.askForAuthorization() {
                        DispatchQueue.main.async {
                            setupController.activePage += 1
                        }
                    }
                }, label: {
                    Text("Connect")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
                
                Button(action: {
                    setupController.activePage += 1
                }, label: {
                    Text("Skip")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.grayGradient))
            }
            .padding(.vertical)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SetupPageHealthKitView()
        .environmentObject(HealthKitController())
        .environmentObject(SetupController())
}
