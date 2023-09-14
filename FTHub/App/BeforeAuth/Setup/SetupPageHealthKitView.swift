//
//  SetupPageHealthKitView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI
import SwiftData

struct SetupPageHealthKitView: View {
    
    @Environment(HealthKitController.self) private var healthKitController
    @Environment(SetupController.self) private var setupController
    
    @Query private var user: [User]
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "Improve your", bottomPart: "whole experience")
                
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been ")
            }
            .padding(.top)
            
            AppleHealthIntegrateView()
                .padding(.vertical, 30)
            
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: {
                    healthKitController.askForAuthorization() { success in
                        if success {
                            if let user = user.first {
                                DispatchQueue.main.async {
                                    setupController.activePage += 1
                                    user.details?.setupActivePage += 1
                                }
                            }
                        } else {
                            Message.send(type: "error", message: "There was an error accessing Apple Health Data")
                        }
                    }
                }, label: {
                    Text("Connect")
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
                
                Button(action: {
                    if let user = user.first {
                        user.details?.setupActivePage += 1
                    }
                    setupController.activePage += 1
                }, label: {
                    Text("Skip")
                        .foregroundStyle(.textGray)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                })
                .buttonStyle(CTAButtonStyle(gradient: K.Gradients.lightGrayGradient))
            }
            .padding(.vertical)
            
            
        }
        .padding()
    }
}

#Preview {
    SetupPageHealthKitView()
        .environment(SetupController())
}
