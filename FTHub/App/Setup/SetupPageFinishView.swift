//
//  SetupPageFinishView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 3.09.23.
//

import SwiftUI
import SwiftData

struct SetupPageFinishView: View {
    
    @EnvironmentObject private var setupController: SetupController
    @Environment(\.modelContext) private var modelContext
    
    @AppStorage("hasDetails") private var hasDetails: Bool = false
    
    @Query private var user: [User]
    
    var body: some View {
        VStack {
            Image("setup5")
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "You finished", bottomPart: "account setup")
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been ")
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                Task {
                    await setupController.saveDetailsToServer() { success in
                        hasDetails = true
                        if let user = user.first {
                            user.details?.setupActivePage = 0
                        }
                    }
                }
            }, label: {
                Text("Done")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
        }
    }
}

#Preview {
    SetupPageFinishView()
        .environmentObject(SetupController())
}
