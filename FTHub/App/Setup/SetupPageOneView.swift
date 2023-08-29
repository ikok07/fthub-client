//
//  SetupPageOneView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI

struct SetupPageOneView: View {
    
    @EnvironmentObject private var setupController: SetupController
    
    var body: some View {
        ScrollView {
            Image("setup0")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 30)
            
            VStack(spacing: 15) {
                TwoLineHeadingView(upperPart: "Let's setup", bottomPart: "your account")
                
                HeadlineView(text: "We need some data to make sure you have the best experience")
            }
            .padding(.horizontal)
            
            Button(action: {
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
    SetupPageOneView()
}
