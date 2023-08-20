//
//  CustomNumpadButtonStyle.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 19.08.23.
//

import SwiftUI

struct CustomNumpadButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background (configuration.isPressed ? .ultraThickMaterial : .ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

