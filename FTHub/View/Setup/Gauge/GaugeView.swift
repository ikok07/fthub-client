//
//  GaugeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct GaugeView: View {
    
    @Binding var percentage: Double
    @Binding var text: String
    
    func calcPercentage() -> CGFloat {
        return 0.1 + percentage * 0.7
    }
    
    var body: some View {
        ZStack() {
            UIKitGaugeView()
        }
    }
}

#Preview {
    GaugeView(percentage: .constant(0.2), text: .constant("45 kg"))
}
