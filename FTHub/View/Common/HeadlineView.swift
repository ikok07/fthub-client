//
//  TutorialHeadlineView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct HeadlineView: View {
    
    let text: String
    
    var body: some View {
        Text(self.text)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.textGray)
            .fontWeight(.semibold)
    }
}

#Preview {
    HeadlineView(text: "Discover all your fitness apps in one place. Create workouts or enter one of our custom fitness programs")
}
