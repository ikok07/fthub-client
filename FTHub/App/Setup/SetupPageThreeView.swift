//
//  SetupPageThreeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import SwiftUI

struct SetupPageThreeView: View {
    
    @State private var age: Int = 18
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "What is", bottomPart: "your age")
                
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been")
            }
            
            VStack {
                VStack {
                    Text("\(age)")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                    Text("years")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
            }
            
            Button(action: {}, label: {
                Text("Continue")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            })
            .buttonStyle(CTAButtonStyle(gradient: K.Gradients.mainGradient))
        }
        .padding()
    }
}

#Preview {
    SetupPageThreeView()
}
