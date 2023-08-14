//
//  CTAButtonStyle.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 14.08.23.
//

import Foundation
import SwiftUI

struct CTAButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundStyle(.white)
            .fontWeight(.bold)
            .background {
                K.mainGradient
            }
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}
