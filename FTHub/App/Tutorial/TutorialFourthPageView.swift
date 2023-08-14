//
//  TutorialFIfthPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialFourthPageView: View {
    var body: some View {
        VStack {
            Spacer()
            TutorialImageView(imageName: "tutorial5")
                .padding(.bottom, 10)
            
            VStack(spacing: 20) {
                TutorialHeadingView(upperPart: "ease your progress", bottomPart: "with our coaches")
                
                TutorialHeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd")
            }
            
            Spacer()
            TutorialPageIndicatorView(pageNumber: 3)
                .padding(.bottom)
        }
        .padding(.horizontal)
    }
}

#Preview {
    TutorialFourthPageView()
}
