//
//  TutorialSecondPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialSecondPageView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Spacer()
            TutorialImageView(imageName: "tutorial3")
                .padding(.bottom, 30)
            
            VStack(spacing: 20) {
                TutorialHeadingView(upperPart: "track all", bottomPart: "your statistics")
                
                TutorialHeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd")
            }
            .padding(.horizontal)
            
            Spacer()
            TutorialPageIndicatorView(pageNumber: 1, selectedTab: $selectedTab)
                .padding(.bottom)
                .padding(.horizontal)
        }
    }
}

#Preview {
    TutorialSecondPageView(selectedTab: .constant(0))
}
