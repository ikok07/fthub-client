//
//  FakeLaunchScreenView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 25.08.23.
//

import SwiftUI

struct FakeLaunchScreenView: View {
    
    @State private var animationValue: Double = 1
    
    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 90)
            .opacity(animationValue)
            .animation(.easeOut(duration: 0.1), value: animationValue)
            .scaleEffect(animationValue)
            .animation(.easeOut(duration: 0.75), value: animationValue)
            .onAppear {
                animationValue = 0
            }
    }
}

#Preview {
    FakeLaunchScreenView()
}
