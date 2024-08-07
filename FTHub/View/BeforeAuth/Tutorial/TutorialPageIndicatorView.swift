//
//  TutorialPageIndicatorView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import SwiftUI

struct TutorialPageIndicatorView: View {
    
    let pageNumber: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            HStack(spacing: 15) {
                ForEach(0..<5) { i in
                    Circle()
                        .frame(width: 13)
                        .foregroundStyle(pageNumber == i ? .accent : .customGray)
                }
            }
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        selectedTab += 1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundStyle(K.Gradients.mainGradient)
                })
            }
            .padding(.trailing, 10)
        }
    }
}

#Preview {
    TutorialPageIndicatorView(pageNumber: 0, selectedTab: .constant(0))
        .padding(.horizontal)
}
