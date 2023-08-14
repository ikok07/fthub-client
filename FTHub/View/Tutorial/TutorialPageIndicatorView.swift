//
//  TutorialPageIndicatorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialPageIndicatorView: View {
    
    let pageNumber: Int
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(0..<5) { i in
                Circle()
                    .frame(width: 13)
                    .foregroundStyle(pageNumber == i ? .accent : .customGray)
            }
        }
    }
}

#Preview {
    TutorialPageIndicatorView(pageNumber: 0)
}
