//
//  CustomHeadingView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialHeadingView: View {
    
    let upperPart: String
    let bottomPart: String
    
    var body: some View {
        VStack {
            Text(self.upperPart.uppercased())
                .font(.title2)
                .fontWeight(.regular)
            
            Text(self.bottomPart.uppercased())
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    TutorialHeadingView(upperPart: "Welcome to FTHub", bottomPart: "Train smart")
}
