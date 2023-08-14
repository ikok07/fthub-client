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
                .padding(.bottom, 10)
            
            VStack(spacing: 20) {
                CustomHeadingView(upperPart: "Create your", bottomPart: "Own Workout")
                
                TutorialHeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd")
            }
            
            Spacer()
            TutorialPageIndicatorView(pageNumber: 0)
        }
        .padding(.horizontal)
    }
}

#Preview {
    TutorialFirstPageView()
}
