//
//  SetupPageFourView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
// 

import SwiftUI

struct SetupHeightPageView: View {
    
    @EnvironmentObject private var setupController: SetupController
    
    var body: some View {
        VStack {
            UnitSelectView()
            
            TwoLineHeadingView(upperPart: "Let's select", bottomPart: "your height")
            
            Spacer()
            
            VerticalNumberSelectorView()
            
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
    SetupHeightPageView()
}
