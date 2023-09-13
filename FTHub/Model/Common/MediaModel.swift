//
//  MediaModel.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import Foundation
import UIKit

struct ImageMedia: NetworkCapable {
    let key: String
    let data: Data?
    let mimeType: String
    
    init(withImage image: UIImage, key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.data = image.jpegData(compressionQuality: 0.3) ?? nil
    }
}
