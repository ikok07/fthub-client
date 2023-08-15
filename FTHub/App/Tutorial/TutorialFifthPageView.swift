//
//  TutorialSixthPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialFifthPageView: View {
    var body: some View {
        VStack {
            Spacer()
            TutorialImageView(imageName: "tutorial6")
                .padding(.bottom, 30)
            
            VStack(spacing: 20) {
                TutorialHeadingView(upperPart: "track all", bottomPart: "your statistics")
                
                TutorialHeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd")
            }
            .padding(.horizontal)
            
            Spacer()
            Button {
                
            } label: {
                Text("Finish Tutorial")
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            .buttonStyle(CTAButtonStyle())
            .padding(.horizontal, 30)

        }
    }
}

#Preview {
    TutorialFifthPageView()
}
