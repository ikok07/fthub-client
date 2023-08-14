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
                .padding(.bottom, 10)
            
            VStack(spacing: 20) {
                TutorialHeadingView(upperPart: "track all", bottomPart: "your statistics")
                
                TutorialHeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd")
            }
            
            Spacer()
            TutorialPageIndicatorView(pageNumber: 4)
                .padding(.bottom)
        }
        .padding(.horizontal)
    }
}

#Preview {
    TutorialFifthPageView()
}
