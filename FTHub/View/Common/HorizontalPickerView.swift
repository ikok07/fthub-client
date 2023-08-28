//
//  HorizontalPickerView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import Foundation
import SwiftUI

struct HorizontalPickerView<Content: View>: UIViewRepresentable {
    
    var content: Content
    @Binding var offset: CGFloat
    var pickerCount: Int
    
    init(pickerCount: Int, offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self.pickerCount = pickerCount
        self.content = content()
        self._offset = offset
    }
    
    func makeUIView(context: Context) -> some UIScrollView {
        
        let scrollView = UIScrollView()
        
        let swiftUIView = UIHostingController(rootView: content).view!
        
        let width = CGFloat(pickerCount * 20) + (UIScreen.main.bounds.width - 30)
        
        swiftUIView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        
        scrollView.contentSize = swiftUIView.frame.size
        scrollView.addSubview(swiftUIView)
        return scrollView
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

//#Preview {
//    HorizontalPickerView()
//}
