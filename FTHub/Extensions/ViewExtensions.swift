//
//  ViewExtension.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 17.08.23.
//

import Foundation
import SwiftUI

struct WithCustomMessage: ViewModifier {
    let isPresented: Bool
    let type: CustomMessageType
    let message: String
    
    func body(content: Content) -> some View {
        content
        ZStack {
            if isPresented {
                VStack {
                    CustomMessageView(type: type, message: message)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
            }
        }
        .animation(.easeOut(duration: 0.2), value: isPresented)
    }
}

extension View {
    @ViewBuilder
    func withCustomMessage(controller: MessageController) -> some View {
        self.modifier(WithCustomMessage(isPresented: controller.messagePresented, type: controller.messageType, message: controller.messageText))
    }
}
