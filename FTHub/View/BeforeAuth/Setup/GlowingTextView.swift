//
//  GlowingTextView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct GlowingTextView: View {
    
    @State private var opacity: Double = 1
    let text: String
    
    var body: some View {
        ZStack() {
            Text(text)
                .foregroundStyle(.black.opacity(opacity))
                .animation(.easeInOut(duration: 1.25).repeatForever(autoreverses: true), value: opacity)
        }
        .onAppear {
            if opacity == 1 {
                opacity = 0.7
            } else {
                opacity = 1
            }
        }
    }
}

#Preview {
    GlowingTextView(text: "Hello, World!")
}
