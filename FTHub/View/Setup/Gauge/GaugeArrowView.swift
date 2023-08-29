//
//  GaugeArrowview.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct GaugeArrowView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Color.green
                .frame(width: 3, height: 80)
            
            ZStack {
                Circle()
                    .frame(width: 25)
                    .foregroundStyle(K.Gradients.mainGradient)
                
                Circle()
                    .frame(width: 7)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    GaugeArrowView()
}
