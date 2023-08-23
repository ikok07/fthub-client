//
//  ViewExtension.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 17.08.23.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    
    func withCustomMessage() -> some View {
        self.modifier(WithCustomMessageModifier())
    }
    
    func withLoadingAnimation() -> some View {
        self.modifier(WithLoadingAnimationModifier())
    }
}
