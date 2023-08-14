//
//  TutorialImageView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialImageView: View {
    
    let imageName: String
    
    var body: some View {
        Image(self.imageName)
            .resizable()
            .scaledToFit()   
    }
}

#Preview {
    TutorialImageView(imageName: "tutorial1")
}
