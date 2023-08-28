//
//  HorizontalPickerView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 28.08.23.
//

import Foundation
import SwiftUI

struct HorizontalPickerUIKitView<Content: View>: UIViewRepresentable {
    
    var content: Content
    @Binding var offset: CGFloat
    var pickerCount: Int
    
    init(pickerCount: Int, offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self.pickerCount = pickerCount
        self.content = content()
        self._offset = offset
    }
    
    func makeCoordinator() -> Coordinator {
        return HorizontalPickerUIKitView.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIScrollView {
        
        let scrollView = UIScrollView()
        
        let swiftUIView = UIHostingController(rootView: content).view!
        
        let width = CGFloat(((pickerCount * 5) * 20)) + (UIScreen.main.bounds.width - 30)
        
        swiftUIView.frame = CGRect(x: 0, y: 0, width: width, height: 20)
        
        scrollView.contentSize = swiftUIView.frame.size
        scrollView.addSubview(swiftUIView)
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        return scrollView
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var parent: HorizontalPickerUIKitView
        
        init(parent: HorizontalPickerUIKitView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            let offset = scrollView.contentOffset.x
            
            let value = (offset / 20).rounded(.toNearestOrAwayFromZero)
            scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: false)
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            
            if !decelerate {
                let offset = scrollView.contentOffset.x
                
                let value = (offset / 20).rounded(.toNearestOrAwayFromZero)
                scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: true)
            }
            
        }
        
    }
    
}

//#Preview {
//    HorizontalPickerView()
//}
