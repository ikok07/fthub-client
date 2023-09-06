//
//  CTAButtonStyle.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import Foundation
import SwiftUI

struct CTAButtonStyle: ButtonStyle {
    
    let gradient: LinearGradient
    let opacity: Double
    
    init(gradient: LinearGradient, opacity: Double? = nil) {
        self.gradient = gradient
        self.opacity = opacity ?? 1
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .background {
                if configuration.isPressed {
                    gradient.opacity(self.opacity - 0.2)
                } else {
                    gradient.opacity(self.opacity)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}
