//
//  withLoadingAnimation.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.08.23.
//

import SwiftUI

struct WithLoadingAnimationModifier: ViewModifier {
    
    @FetchRequest(sortDescriptors: []) private var variables: FetchedResults<AppVariables>
    @State private var rotation: Double = 360
    
    func body(content: Content) -> some View {
        content
        ZStack {
            if variables[0].loadingPresented {
                
            RoundedRectangle(cornerRadius: 0)
                .foregroundStyle(.ultraThinMaterial)
                .ignoresSafeArea()
            
                Circle()
                    .stroke(K.Gradients.grayGradient.opacity(0.5), lineWidth: 7)
                    .frame(width: 50, height: 50)
                
                Circle()
                    .trim(from: 0.6, to: 1)
                    .stroke(K.Gradients.mainGradient, lineWidth: 7)
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        if rotation == 360 {
                            rotation = 0
                        } else {
                            rotation = 360
                        }
                    }
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.easeOut, value: variables[0].loadingPresented)
    }
    
}
