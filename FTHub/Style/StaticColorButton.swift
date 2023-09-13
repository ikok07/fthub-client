//
//  WhiteButtonStyle.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import Foundation
import SwiftUI

struct StaticColorButton: ButtonStyle {
    
    let bg: Color
    let text: Color
    let opacity: Double
    
    let width: Double?
    let cornerRadius: Double?
    
    init(bg: Color, text: Color, opacity: Double? = nil, width: Double? = nil, cornerRadius: Double? = nil) {
        self.bg = bg
        self.text = text
        self.opacity = opacity ?? 1
        self.width = width
        self.cornerRadius = cornerRadius
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: width ?? .infinity)
            .foregroundStyle(text)
            .fontWeight(.bold)
            .background {
                if configuration.isPressed {
                    bg.opacity(self.opacity - 0.2)
                } else {
                    bg.opacity(self.opacity)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}
