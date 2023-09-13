//
//  BMIArcShapeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 11.09.23.
//

import SwiftUI
import SwiftUIGauge

struct BMIArcShapeView: View {
    
    let value: Double
    let width: CGFloat
    let borderWidth: CGFloat
    let arrowLength: CGFloat
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(BMIController.bmiRanges, id: \.0) { classification, startBMI, endBMI in
                    let startDegrees = BMIController.mapValueToDegrees(endBMI)
                    let endDegrees = BMIController.mapValueToDegrees(startBMI)
                    
                    ArcShape(width: width, startDegrees: startDegrees, endDegrees: endDegrees)
                        .stroke(Color.arcColor(for: classification), style: StrokeStyle(lineWidth: borderWidth))
                        .rotationEffect(.degrees(180))
                }
                
                GaugeArrowShape(anchorDiameter: 30, arrowLength: arrowLength, cornerRadius: 5)
                    .fill(K.Gradients.mainGradient)
                    .rotationEffect(.degrees(-90))
                    .rotationEffect(.degrees(BMIController.getArrowDegrees(value: self.value)))
                
                GaugeCenterCircleView(arrowAnchorMainCircleDiameter: 30, arrowAnchorSecondaryCircleDiameter: 10, arrowAnchorMainCircleGradient: K.Gradients.mainGradient, arrowAnchorSecondaryCircleGradient: K.Gradients.whiteGradient)
                
                BMIArcLabelsView(width: self.width, borderWidth: self.borderWidth)
            }
        }
    }
}

#Preview {
    BMIArcShapeView(value: 20.1, width: 250, borderWidth: 30, arrowLength: 80)
}
