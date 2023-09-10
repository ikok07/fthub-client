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
    let maxVal: Double = 40
    
    var body: some View {
        VStack {
            ZStack {
                ArcShape(width: width, startDegrees: -167.5, endDegrees: 180)
                    .stroke(.arc1, style: StrokeStyle(lineWidth: borderWidth, lineCap: .round))
                ArcShape(width: width, startDegrees: -158.5, endDegrees: 192.5)
                    .stroke(.arc2, style: StrokeStyle(lineWidth: borderWidth))
                ArcShape(width: width, startDegrees: -147.25, endDegrees: 201)
                    .stroke(.arc3, style: StrokeStyle(lineWidth: borderWidth))
                ArcShape(width: width, startDegrees: -117.55, endDegrees: 212.5)
                    .stroke(.arc4, style: StrokeStyle(lineWidth: borderWidth))
                ArcShape(width: width, startDegrees: -90.55, endDegrees: 242.2)
                    .stroke(.arc3, style: StrokeStyle(lineWidth: borderWidth))
                
                //REVERSED
                ArcShape(width: width, startDegrees: 0, endDegrees: 296.2)
                    .stroke(.arc1, style: StrokeStyle(lineWidth: borderWidth, lineCap: .round))
                ArcShape(width: width, startDegrees: -63.55, endDegrees: 269.2)
                    .stroke(.arc2, style: StrokeStyle(lineWidth: borderWidth))
                //REVERSED
                
                GaugeArrowShape(anchorDiameter: 30, arrowLength: 70, cornerRadius: 5)
                    .fill(K.Gradients.mainGradient)
                    .rotationEffect(.degrees(-90))
                    .rotationEffect(forAdults ? .degrees(((value / maxVal) * 180) - 35) : .degrees((value / maxVal) * 100) * 180)
                
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
