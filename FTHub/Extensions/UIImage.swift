//
//  UIImage.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation
import SwiftUI
import UIKit

extension UIImage {
    
    func compressImage(quality: Double) -> UIImage {
        let resizedImage = self.aspectFittedToHeight(100)
        resizedImage.jpegData(compressionQuality: quality)
        
        return resizedImage
    }
    
    
    private func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
