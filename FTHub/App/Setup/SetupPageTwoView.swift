//
//  SetupPageSecondView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 27.08.23.
//

import SwiftUI

struct SetupPageTwoView: View {
    var body: some View {
        ScrollView {
            Image("setup1")
                .resizable()
                .scaledToFit()
                .padding(.vertical, 30)
            
            TwoLineHeadingView(upperPart: "Please select", bottomPart: "your gender")
            
            VStack(spacing: 20) {
                GenderSelectRowView(gender: .male, active: true)
                
                GenderSelectRowView(gender: .female, active: false)
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            
            Button {
                
            } label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
            .padding()
            .padding(.top, 40)

        }
    }
}

#Preview {
    SetupPageTwoView()
}
