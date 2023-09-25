//
//  WithCustomMessageModifier.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 23.08.23.
//

import SwiftUI

struct WithCustomMessageModifier: ViewModifier {
    
    @FetchRequest(sortDescriptors: []) var variables: FetchedResults<AppVariables>
    
    func body(content: Content) -> some View {
        content
        ZStack {
            if variables[0].messagePresented {
                VStack {
                    CustomMessageView(type: variables[0].messageType!, message: variables[0].messageContent!)
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)
            }
        }
        .animation(.easeOut(duration: 0.2), value: variables[0].messagePresented)
    }
}
