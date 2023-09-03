//
//  SetupPageNotificationsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 1.09.23.
//

import SwiftUI
import SwiftData

struct SetupPageNotificationsView: View {
    
    @EnvironmentObject private var setupController: SetupController
    @Query private var user: [User]
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "Always knows", bottomPart: "what's happening")
                
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been ")
            }
            .padding(.top)
            
            Image("setup4")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            VStack(spacing: 10) {
                Button(action: {
                    NotificationsController.requestPermission { success, error in
                        DispatchQueue.main.async {
                            if success {
                                if let user = user.first {
                                    user.details?.setupActivePage += 1
                                }
                                setupController.activePage += 1
                            } else if error != nil {
                                print("Error getting permission for notifications: \(error!)")
                                Message.send(type: "error", message: "An error occurred")
                            }
                        }
                    }
                }, label: {
                    Text("Allow Notifications")
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
    SetupPageNotificationsView()
        .environmentObject(SetupController())
}
