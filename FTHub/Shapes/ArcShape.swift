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
