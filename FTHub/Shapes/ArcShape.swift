//
//  ArcOutputShape.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 10.09.23.
//

import SwiftUI
import SwiftUIGauge

struct ArcShape: Shape {
    
    let width: CGFloat
    let startDegrees: Double
    let endDegrees: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center: CGPoint = CGPoint(x: rect.midX, y: rect.midY)
        
        path.addArc(center: center, radius: width / 2, startAngle: .degrees(startDegrees), endAngle: .degrees(endDegrees), clockwise: true)
        
        return path
    }
}

struct BMIArcShapeView: View {
    
    @State var value: Double = 16
    @State var forAdults: Bool = true
    
    let width: CGFloat
    let borderWidth: CGFloat
    
    let minVal: Double = 12
    let maxVal: Double = 46
    
    var arrowRotation: Double {
        if forAdults {
            return ((value / maxVal) * 180)
        } else {
            return (value / maxVal) * 100 * 180
        }
    }
    
    let bmiRanges: [(String, Double, Double)] = [
        ("Severe Thinness", 0, 16),
        ("Moderate Thinness", 16, 17),
        ("Mild Thinness", 17, 18.5),
        ("Normal", 18.5, 25),
        ("Overweight", 25, 30),
        ("Obese Class I", 30, 35),
        ("Obese Class II", 35, 40),
        ("Obese Class III", 40, 100)
    ]
    
    func mapValueToDegrees(_ bmiValue: Double) -> Double {
        let normalizedValue = max(min(bmiValue, maxVal), minVal)
        return (normalizedValue - minVal) / (maxVal - minVal) * 180
    }
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(bmiRanges, id: \.0) { classification, startBMI, endBMI in
                    let startDegrees = mapValueToDegrees(endBMI) // Reverse the start and end degrees
                    let endDegrees = mapValueToDegrees(startBMI) // Reverse the start and end degrees
                    ArcShape(width: width, startDegrees: startDegrees, endDegrees: endDegrees)
                        .stroke(Color.arcColor(for: classification), style: StrokeStyle(lineWidth: borderWidth))
                        .rotationEffect(.degrees(180))
                }
                
                GaugeArrowShape(anchorDiameter: 30, arrowLength: 70, cornerRadius: 5)
                    .fill(K.Gradients.mainGradient)
                    .rotationEffect(.degrees(-90))
                    .rotationEffect(.degrees(arrowRotation))
                
                GaugeCenterCircleView(arrowAnchorMainCircleDiameter: 30, arrowAnchorSecondaryCircleDiameter: 10, arrowAnchorMainCircleGradient: K.Gradients.mainGradient, arrowAnchorSecondaryCircleGradient: K.Gradients.whiteGradient)
                
                BMIArcLabelsView(width: self.width, borderWidth: self.borderWidth)
            }
        }
    }
}

struct BMIArcLabelsView: View {
    
    let width: CGFloat
    let borderWidth: CGFloat
    
    var body: some View {
        HStack {
            Text("Underweight")
                .foregroundStyle(.textGray)
                .font(.footnote)
                .offset(x: -borderWidth / 1.5)
            
            Spacer()
            
            Text("Obesity")
                .foregroundStyle(.textGray)
                .font(.footnote)
                .offset(x: borderWidth / 2.5)
        }
        .frame(maxWidth: width + borderWidth)
        .offset(y: 30)
    }
}

#Preview {
    BMIArcShapeView(width: 250, borderWidth: 30)
}
