//
//  ViewExtension.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 17.08.23.
//

import Foundation
import SwiftUI

struct WithCustomMessage: ViewModifier {
    
    @AppStorage("messagePresented") private var messagePresented: Bool = false
    @AppStorage("messageContent") private var messageContent: String = ""
    @AppStorage("messageType") private var messageType: String = "success"
    
    func body(content: Content) -> some View {
        content
        ZStack {
            if messagePresented {
                VStack {
                    CustomMessageView(type: messageType, message: messageContent)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
            }
        }
        .animation(.easeOut(duration: 0.2), value: messagePresented)
    }
}

extension View {
    @ViewBuilder
    func withCustomMessage() -> some View {
        self.modifier(WithCustomMessage())
    }
}
