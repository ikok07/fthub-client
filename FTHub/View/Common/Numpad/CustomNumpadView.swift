//
//  CustomNumpadView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 19.08.23.
//

import SwiftUI

struct CustomNumpadView: View {
    var body: some View {
        VStack {
            LazyVGrid(columns: K.GridLayouts.standardColumnLayout, content: {
                ForEach(1..<10) { value in
                    NumpadButtonView(value: String(value))
                }
                NumpadButtonView(value: " ")
                NumpadButtonView(value: "0")
                NumpadButtonView(value: "delete.left")
            })
            .padding(.horizontal, 5)
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .background(.ultraThinMaterial)
    }
}

#Preview {
    CustomNumpadView()
}
