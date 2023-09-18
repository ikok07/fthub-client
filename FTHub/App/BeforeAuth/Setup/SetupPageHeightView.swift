//
//  SetupPageFourView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
// 

import SwiftUI
import SwiftData

struct SetupPageHeightView: View {
    
    @Environment(SetupController.self) private var setupController
    
    @Query private var user: [User]
    
    @State private var userHeight: Double?
    
    var body: some View {
        VStack {
            UnitSelectView()
            
            TwoLineHeadingView(upperPart: "Let's select", bottomPart: "your height")
            
            Spacer()
            
            VerticalNumberSelectorView(userHeight: $userHeight)
            
            Button(action: {
                if let user = user.first {
                    user.details?.setupActivePage += 1
                    user.details?.height = Int(userHeight ?? 170)
                }
                setupController.activePage += 1
            }, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
        }
    }
}

#Preview {
    SetupPageHeightView()
        .environment(SetupController())
}
