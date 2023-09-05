//
//  TutorialFIfthPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialFourthPageView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Spacer()
            TutorialImageView(imageName: "tutorial5")
                .padding(.bottom, 30)
            
            VStack(spacing: 20) {
                TwoLineHeadingView(upperPart: "ease your progress", bottomPart: "with our coaches")
                
                HeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd")
            }
            .padding(.horizontal)
            
            Spacer()
            TutorialPageIndicatorView(pageNumber: 3, selectedTab: $selectedTab)
                .padding(.bottom)
                .padding(.horizontal)
        }
    }
}

#Preview {
    TutorialFourthPageView(selectedTab: .constant(0))
}
