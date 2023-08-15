//
//  TutorialFirstPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialFirstPageView: View {
    var body: some View {
        VStack {
            Spacer()
            TutorialImageView(imageName: "tutorial2")
                .padding(.bottom, 30)
            
            VStack(spacing: 20) {
                TutorialHeadingView(upperPart: "Create your", bottomPart: "Own Workout")
                
                TutorialHeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd")
            }
            .padding(.horizontal)
            
            Spacer()
            TutorialPageIndicatorView(pageNumber: 0)
                .padding(.bottom)
                .padding(.horizontal)
        }
    }
}

#Preview {
    TutorialFirstPageView()
}
