//
//  TutorialMainView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialMainView: View {
    
    @State private var tutorialStarted: Bool = false
    @State private var selectedTab: Int = 0
    
    var body: some View {
        if self.tutorialStarted {
            TabView(selection: $selectedTab) {
                TutorialFirstPageView(selectedTab: $selectedTab)
                    .tag(0)
                TutorialSecondPageView(selectedTab: $selectedTab)
                    .tag(1)
                TutorialThirdPageView(selectedTab: $selectedTab)
                    .tag(2)
                TutorialFourthPageView(selectedTab: $selectedTab)
                    .tag(3)
                TutorialFifthPageView(selectedTab: $selectedTab)
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.horizontal)
        } else {
            TutorialStartPageView(tutorialStarted: $tutorialStarted)
        }
    }
}

#Preview {
    TutorialMainView()
}
