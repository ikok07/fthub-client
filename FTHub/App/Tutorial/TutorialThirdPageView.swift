//
//  TutorialFourthPageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialThirdPageView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Spacer()
            TutorialImageView(imageName: "tutorial4")
                .padding(.bottom, 30)
            
            VStack(spacing: 20) {
                TutorialHeadingView(upperPart: "experience our", bottomPart: "machine learning")
                
                TutorialHeadlineView(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has asdasdasdasd")
            }
            .padding(.horizontal)
            
            Spacer()
            TutorialPageIndicatorView(pageNumber: 2, selectedTab: $selectedTab)
                .padding(.bottom)
                .padding(.horizontal)
        }
    }
}

#Preview {
    TutorialThirdPageView(selectedTab: .constant(0))
}
