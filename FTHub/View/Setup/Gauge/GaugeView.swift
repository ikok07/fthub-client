//
//  GaugeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct GaugeView: View {
    
//    @Binding var percentage: Double
//    @Binding var text: String
    
//    func calcPercentage() -> CGFloat {
//        return 0.1 + percentage * 0.7
//    }
    
    var body: some View {
        ZStack() {
//            GaugeShape()
//                .fill(Color.clear) // Set the fill color
//                .stroke(Color.blue, lineWidth: 10)
//                .frame(width: 300, height: 300) // Set the desired size
            UIKitGaugeView()
        }
    }
}

struct GaugeShape: Shape {
    
    var outerBezelColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
    var outerBezelWidth: CGFloat = 10
    
    var innerBezelColor = UIColor.white
    var innerBezelWidth: CGFloat = 5
    
    var insideColor = UIColor.white
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addEllipse(in: rect)

        let innerBezelRect = rect.insetBy(dx: outerBezelWidth, dy: outerBezelWidth)
        path.addEllipse(in: innerBezelRect)

        let insideRect = innerBezelRect.insetBy(dx: innerBezelWidth, dy: innerBezelWidth)
        path.addEllipse(in: insideRect)

        return path
    }
}

#Preview {
    GaugeView()
}
