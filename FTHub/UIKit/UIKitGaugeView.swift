//
//  UIKitGaugeView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 29.08.23.
//

import SwiftUI

struct UIKitGaugeView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return GaugeViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class GaugeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gaugeView = GaugeUIView(frame: view.bounds)
        view.addSubview(gaugeView)
    }
    
    
}

class GaugeUIView: UIView {
    
    var outerBezelColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
    var outerBezelWidth: CGFloat = 10
    
    var innerBezelColor = UIColor.white
    var innerBezelWidth: CGFloat = 5
    
    var insideColor = UIColor.white
    
    func drawBackground(in rect: CGRect, context ctx: CGContext) {
        outerBezelColor.set()
        ctx.fillEllipse(in: rect)
        
        let innerBezelRect = rect.insetBy(dx: outerBezelWidth, dy: outerBezelWidth)
        innerBezelColor.set()
        ctx.fillEllipse(in: innerBezelRect)
        
        let insideRect = innerBezelRect.insetBy(dx: innerBezelWidth, dy: innerBezelWidth)
        insideColor.set()
        ctx.fillEllipse(in: insideRect)
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        drawBackground(in: rect, context: ctx)
    }
}
