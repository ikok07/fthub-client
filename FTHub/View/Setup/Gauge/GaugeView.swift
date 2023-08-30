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
    
    let majorTickLength: CGFloat = 20
    
    let arrowLenght: CGFloat = 120
    let arrowAnchorMainCircleDiameter: CGFloat = 35
    let arrowAnchorSecondaryCircleDiameter: CGFloat = 10
    let arrowCornerRadius: CGFloat = 5 // Adjust this value to control the roundness
    
    
    func calcPercentage() -> CGFloat {
        return 0.1 + percentage * 0.7
    }
    
    var body: some View {
        VStack {
            ZStack() {
                Circle()
                    .trim(from: 0.2, to: 0.8)
                    .stroke(K.Gradients.grayGradient, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .frame(width: 350)
                    .rotationEffect(.degrees(90))
                
                Circle()
                    .trim(from: 0.2, to: calcPercentage())
                    .stroke(K.Gradients.mainGradient, style: StrokeStyle(lineWidth: 25, lineCap: .round))
                    .frame(width: 350)
                    .rotationEffect(.degrees(90))

                

                GaugeTicksShape()
                    .stroke(.textGray, lineWidth: 3)
                    .frame(width: 350, height: 350)
                    .rotationEffect(.degrees(-105))
                ZStack {
                    GaugeArrowShape(anchorDiameter: arrowAnchorMainCircleDiameter, arrowLenght: self.arrowLenght, cornerRadius: self.arrowCornerRadius, rotationAngle: .degrees(0))
                        .fill(K.Gradients.mainGradient)
                    
                    GaugeCenterCircleView(arrowAnchorMainCircleDiameter: self.arrowAnchorMainCircleDiameter, arrowAnchorSecondaryCircleDiameter: self.arrowAnchorSecondaryCircleDiameter)
                }
                .offset(y: 30)
                
                
            }
            .frame(width: 350, height: 350)
            
            Text(text)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .offset(y: -20)
                .contentTransition(.numericText())
        }
    }
}

struct GaugeTicksShape: Shape {
    
    let totalAngle: CGFloat = 180
    let numberOfMajorTicks: Int = 6
    let majorTickLength: CGFloat = 20
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let centerX = rect.midX
        let centerY = rect.midY
         
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        
        let segmentAngle: Angle = Angle.degrees(totalAngle / Double(numberOfMajorTicks - 1))
        let segmentRadius = ((rect.width - majorTickLength) / 2) - 40
        
        
        for i in 0...numberOfMajorTicks {
            let tickAngle = Angle(degrees: Double(i) * segmentAngle.degrees - totalAngle / 2)
            let startX = centerX + CGFloat(cos(tickAngle.radians)) * segmentRadius
            let startY = centerY + CGFloat(sin(tickAngle.radians)) * segmentRadius
            let endX = startX + CGFloat(cos(tickAngle.radians)) * majorTickLength
            let endY = startY + CGFloat(sin(tickAngle.radians)) * majorTickLength
            
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: endX, y: endY))
        }
        
        return path
    }
}

struct GaugeArrowShape: Shape {
    
    let anchorDiameter: Double
    
    let arrowLenght: CGFloat
    let cornerRadius: CGFloat // Adjust this value to control the roundness
    let rotationAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX - anchorDiameter / 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - 4, y: rect.midY - arrowLenght))
        path.addQuadCurve(to: CGPoint(x: rect.midX + 4, y: rect.midY - arrowLenght),
                          control: CGPoint(x: rect.midX, y: rect.midY - arrowLenght - cornerRadius))
        path.addLine(to: CGPoint(x: rect.midX + anchorDiameter / 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - anchorDiameter / 2, y: rect.midY))
        let rotatedPath = path.applying(CGAffineTransform(rotationAngle: CGFloat(rotationAngle.radians)))
        
        return rotatedPath
    }
}

struct GaugeCenterCircleView: View {
    
    let arrowAnchorMainCircleDiameter: CGFloat
    let arrowAnchorSecondaryCircleDiameter: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(K.Gradients.mainGradient)
                .frame(width: arrowAnchorMainCircleDiameter, height: arrowAnchorMainCircleDiameter)
            Circle()
                .foregroundStyle(.white)
                .frame(width: arrowAnchorSecondaryCircleDiameter, height: arrowAnchorSecondaryCircleDiameter)
        }
    }
}

#Preview {
    GaugeView(percentage: .constant(0.25), text: .constant("75 kg"))
}
