//
//  TutorialMainView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialMainView: View {
    
    @State private var tutorialStarted: Bool = false
    
    var body: some View {
        if self.tutorialStarted {
            TabView {
                
            }
            .tabViewStyle(.page)
            .padding(.horizontal)
        } else {
            TutorialStartPageView(tutorialStarted: $tutorialStarted)
        }
    }
}

#Preview {
    TutorialMainView()
}
